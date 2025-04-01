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

/// The store for the chat.
class ChatStore = ChatStoreBase with _$ChatStore;

/// The base class for the chat store.
abstract class ChatStoreBase with Store {
  /// The scroll controller for the chat.
  final ChatScrollController chatScrollController;

  /// The config for the chat.
  final ChatConfig config;

  /// The text editing controller for the chat.
  final TextEditingController textEditingController = TextEditingController();

  /// The focus node for the chat.
  final FocusNode focusNode = FocusNode();

  /// The constructor of the chat store.
  ChatStoreBase(
    this.chatScrollController,
    this.config,
  ) {
    _setup();
  }

  Future<void> _setup() async {
    // setup
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _isInputBoxFocused = true;
      } else {
        _isInputBoxFocused = false;
      }
    });
  }

  // observables

  /// The sequential message map for the chat.
  final sequentialMessageMap = SequentialMessageMap();

  /// The users for the chat.
  @readonly
  ObservableMap<String, ModelBaseUser> _users =
      ObservableMap<String, ModelBaseUser>.of({});

  /// The current user for the chat.
  @readonly
  ModelBaseUser? _currentUser;

  /// The flag for the input box focused.
  bool _isInputBoxFocused = false;

  // observables - images

  /// The image files for the chat.
  @readonly
  ObservableList<AssetImageInfo> _imageFiles =
      ObservableList<AssetImageInfo>.of([]);

  // observables - send message

  @readonly
  bool _isSending = false;

  @readonly
  int _readSequence = 0;

  @readonly
  bool _hasUnreadMessages = false;

  @readonly
  int _unreadMessagesCount = 0;

  /// The flag for the reach image selection limit.
  @computed
  bool get reachImageSelectionLimit =>
      _imageFiles.length >= config.imageMaxCount;

  // actions

  /// The action for the add message.
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

  /// The action for the add messages.
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

  /// The action for the post message processing.
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

  /// The action for the read message.
  @action
  Future<void> readMessage({
    required ModelBaseMessage message,
  }) async {
    if (message.sequence > _readSequence) {
      _readSequence = message.sequence;
      await updateUnreadStatus();
    }
  }

  /// The action for the read all messages.
  @action
  Future<void> readAllMessages() async {
    _readSequence = sequentialMessageMap.getHighestSequence();
    await updateUnreadStatus();
  }

  /// The action for the update unread status.
  @action
  Future<void> updateUnreadStatus() async {
    final highestSequence = sequentialMessageMap.getHighestSequence();
    _hasUnreadMessages = _readSequence < highestSequence;
    _unreadMessagesCount = sequentialMessageMap.sequentialValues
        .where((message) => message.sequence > _readSequence)
        .length;
  }

  /// The action for the remove message.
  @action
  Future<void> removeMessage({
    required ModelBaseMessage message,
  }) async {
    sequentialMessageMap.remove(message.id);
  }

  /// The action for the remove message by id.
  @action
  Future<void> removeMessageById({
    required String messageId,
  }) async {
    sequentialMessageMap.remove(messageId);
  }

  /// The action for the remove messages.
  @action
  Future<void> removeMessages({
    required List<ModelBaseMessage> messages,
  }) async {
    for (var message in messages) {
      sequentialMessageMap.remove(message.id);
    }
  }

  /// The action for the clear all.
  @action
  Future<void> clearAll() async {
    sequentialMessageMap.clearAll();
  }

  // send status

  /// The action for the update send status.
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

  /// The action for the add user.
  @action
  Future<void> addUser({
    required ModelBaseUser user,
  }) async {
    _users[user.id] = user;
    if (user.isCurrentUser) {
      _currentUser = user;
    }
  }

  /// The action for the add users.
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

  /// The loading indicator message id.
  final loadingIndicatorMessageId = const Uuid().v4();

  /// The action for the send message.
  @action
  Future<void> sendMessage(
      {required Function(ChatMessageSendOutput output) onSend}) async {
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

  /// The action for the take photo.
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

  /// The action for the pick image.
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
        permissionDeniedText: config.photoPermissionDeniedText ??
            'Please grant permission to access your photo library',
        permissionDeniedButtonText:
            config.photoPermissionDeniedButtonText ?? 'Open Settings',
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

  /// The action for the remove image.
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

  /// The action for the show reply generating indicator.
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

  /// The action for the hide reply generating indicator.
  @action
  Future<void> hideReplyGeneratingIndicator() async {
    await removeMessageById(messageId: loadingIndicatorMessageId);
  }

  // public

  /// The method for the is message from current user.
  bool isMessageFromCurrentUser(ModelBaseMessage message) {
    return message.userId == _currentUser?.id;
  }
}
