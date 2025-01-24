import 'dart:async';

import 'package:easy_asset_picker/easy_asset_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart'; // Added import for logger
import 'package:mobx/mobx.dart';
import 'package:simple_chat/controllers/chat_scroll_controller.dart';
import 'package:simple_chat/models/loading_indicator_message.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/stores/sequential_map.dart';
import 'package:uuid/uuid.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;

abstract class ChatStoreBase with Store {
  final ChatScrollController chatScrollController;
  final ChatConfig config;
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  ChatStoreBase(
    this.chatScrollController,
    this.config,
  ) {
    setup();
  }

  Future<void> setup() async {
    // setup
  }

  // observables

  final sequentialMessageMap = SequentialMessageMap();

  @readonly
  ObservableMap<String, ModelBaseUser> _users = ObservableMap<String, ModelBaseUser>.of({});

  @readonly
  ModelBaseUser? _currentUser;

  // observables - images

  @readonly
  ObservableList<AssetImageInfo> _imageFiles = ObservableList<AssetImageInfo>.of([]);

  // observables - send message

  @readonly
  bool _isSending = false;

  @readonly
  int _readSequence = 0;

  @readonly
  bool _hasUnreadMessages = false;

  @readonly
  int _unreadMessagesCount = 0;

  @computed
  bool get reachImageSelectionLimit => _imageFiles.length >= config.imageMaxCount;

  // actions

  @action
  Future<void> addMessage({
    required ModelBaseMessage message,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    sequentialMessageMap.upsert(message);
    unawaited(
      postMessageProcessing(
        isAtBottom: isAtBottom,
        isInitial: isInitial,
        newMessages: [message],
      ),
    );
  }

  @action
  Future<void> addMessages({
    required List<ModelBaseMessage> messages,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    sequentialMessageMap.upsertAll(messages);
    unawaited(
      postMessageProcessing(
        isAtBottom: isAtBottom,
        isInitial: isInitial,
        newMessages: messages,
      ),
    );
  }

  @action
  Future<void> postMessageProcessing({
    required bool isAtBottom,
    required bool isInitial,
    required List<ModelBaseMessage> newMessages,
  }) async {
    if (isAtBottom) {
      _readSequence = sequentialMessageMap.getHighestSequence();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isInitial) {
          chatScrollController.jumpToBottom();
        } else {
          chatScrollController.scrollToBottom();
        }
      });
    } else if (isInitial) {
      _readSequence = sequentialMessageMap.getHighestSequence();
    }
    updateUnreadStatus();
  }

  @action
  Future<void> readMessage({
    required ModelBaseMessage message,
  }) async {
    if (message.sequence > _readSequence) {
      _readSequence = message.sequence;
      await updateUnreadStatus();
    }
  }

  @action
  Future<void> readAllMessages() async {
    _readSequence = sequentialMessageMap.getHighestSequence();
    await updateUnreadStatus();
  }

  @action
  Future<void> updateUnreadStatus() async {
    final highestSequence = sequentialMessageMap.getHighestSequence();
    _hasUnreadMessages = _readSequence < highestSequence;
    _unreadMessagesCount =
        sequentialMessageMap.sequentialValues.where((message) => message.sequence > _readSequence).length;
  }

  @action
  Future<void> removeMessage({
    required ModelBaseMessage message,
  }) async {
    sequentialMessageMap.remove(message.id);
  }

  @action
  Future<void> removeMessageById({
    required String messageId,
  }) async {
    sequentialMessageMap.remove(messageId);
  }

  @action
  Future<void> removeMessages({
    required List<ModelBaseMessage> messages,
  }) async {
    for (var message in messages) {
      sequentialMessageMap.remove(message.id);
    }
  }

  @action
  Future<void> clearAll() async {
    sequentialMessageMap.clearAll();
  }

  // send status

  @action
  Future<void> updateSendStatus({
    required String messageId,
    required ModelBaseMessageStatus status,
  }) async {
    final message = sequentialMessageMap.getById(messageId);
    if (message != null) {
      message.status = status;
      sequentialMessageMap.upsert(message);
    }
  }

  // users

  @action
  Future<void> addUser({
    required ModelBaseUser user,
  }) async {
    _users[user.id] = user;
    if (user.isCurrentUser) {
      _currentUser = user;
    }
  }

  @action
  Future<void> addUsers({
    required List<ModelBaseUser> users,
  }) async {
    for (var user in users) {
      _users[user.id] = user;
      if (user.isCurrentUser) {
        _currentUser = user;
      }
    }
  }

  final loadingIndicatorMessageId = const Uuid().v4();
  @action
  Future<void> sendMessage({required Function(ChatMessageSendOutput output) onSend}) async {
    final output = ChatMessageSendOutput(
      message: textEditingController.text,
      imageFiles: _imageFiles.toList(),
    );
    if (config.loadingIndicatorType == LoadingIndicatorType.sendBtnLoading) {
      _isSending = true;
      try {
        await onSend(output);
        textEditingController.clear();
        _imageFiles.clear();
      } catch (e) {
        Logger().e('Error occurred: $e');
      }
      _isSending = false;
    } else {
      try {
        textEditingController.clear();
        _imageFiles.clear();
        onSend(output);
      } catch (e) {
        Logger().e('Error occurred: $e');
      }
    }
  }

  // actions - images
  bool _isTakingPhoto = false;
  @action
  Future<void> takePhoto(BuildContext context) async {
    if (_isSending || _isTakingPhoto) {
      return;
    }
    _isTakingPhoto = true;
    final isAtBottom = chatScrollController.isAtBottom();
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final updated = _imageFiles.toList();
      updated.add(
        AssetImageInfo(
          path: image.path,
        ),
      );
      _imageFiles = ObservableList<AssetImageInfo>.of(updated);
    }
    if (isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    }
    _isTakingPhoto = false;
  }

  bool _isPickingImage = false;
  @action
  Future<void> pickImage(BuildContext context) async {
    if (_isSending || _isPickingImage) {
      return;
    }
    _isPickingImage = true;
    final isAtBottom = chatScrollController.isAtBottom();
    final results = await showAssetPicker(
      context,
      config: AssetPickerConfig(
        maxSelection: config.imageMaxCount,
        selectIndicatorColor: context.coloredTheme.primary,
        loadingIndicatorColor: context.coloredTheme.primary,
        permissionDeniedText:
            config.photoPermissionDeniedText ?? 'Please grant permission to access your photo library',
        permissionDeniedButtonText: config.photoPermissionDeniedButtonText ?? 'Open Settings',
      ),
    );
    _imageFiles = ObservableList<AssetImageInfo>.of(results ?? []);
    if (isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    }
    _isPickingImage = false;
  }

  @action
  Future<void> removeImage({
    required AssetImageInfo image,
  }) async {
    if (_isSending) {
      return;
    }
    final updated = _imageFiles.toList();
    updated.remove(image);
    _imageFiles = ObservableList<AssetImageInfo>.of(updated);
  }

  // loading indicator

  @action
  Future<void> showReplyGeneratingIndicator() async {
    await addMessage(
      isInitial: false,
      message: ModelLoadingIndicatorMessage(
        id: loadingIndicatorMessageId,
        userId: '',
        sequence: (1 << 63) - 1,
        displayDatetime: DateTime.now(),
      ),
    );
  }

  @action
  Future<void> hideReplyGeneratingIndicator() async {
    await removeMessageById(messageId: loadingIndicatorMessageId);
  }

  // public

  bool isMessageFromCurrentUser(ModelBaseMessage message) {
    return message.userId == _currentUser?.id;
  }
}
