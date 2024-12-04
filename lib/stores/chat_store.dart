import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart'; // Added import for logger
import 'package:mobx/mobx.dart';
import 'package:tealseed_chat/controllers/chat_scroll_controller.dart';
import 'package:tealseed_chat/tealseed_chat.dart';

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

  @readonly
  ObservableList<ModelBaseMessage> _messages = ObservableList<ModelBaseMessage>.of([]);

  @readonly
  ObservableMap<String, ModelBaseUser> _users = ObservableMap<String, ModelBaseUser>.of({});

  @readonly
  ModelBaseUser? _currentUser;

  // observables - images

  @readonly
  ObservableList<XFile> _imageFiles = ObservableList<XFile>.of([]);

  // observables - send message

  @readonly
  bool _isSending = false;

  @computed
  bool get reachImageSelectionLimit => _imageFiles.length >= config.imageMaxCount;

  // actions

  @action
  Future<void> addMessage({
    required ModelBaseMessage message,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    _messages.insert(0, message);
    if (!isInitial && isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    } else if (!isAtBottom) {}
  }

  @action
  Future<void> addMessages({
    required List<ModelBaseMessage> messages,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    _messages.insertAll(0, messages.reversed);
    if (!isInitial && isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    } else if (!isAtBottom) {}
  }

  @action
  Future<void> removeMessage({
    required ModelBaseMessage message,
  }) async {
    _messages.remove(message);
  }

  @action
  Future<void> removeMessageById({
    required String messageId,
  }) async {
    _messages.removeWhere((message) => message.id == messageId);
  }

  @action
  Future<void> removeMessages({
    required List<ModelBaseMessage> messages,
  }) async {
    _messages.removeWhere((message) => messages.contains(message));
  }

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

  @action
  Future<void> sendMessage({required Function(TealseedChatMessageSendOutput output) onSend}) async {
    _isSending = true;
    final output = TealseedChatMessageSendOutput(
      message: textEditingController.text,
      imageFiles: _imageFiles.toList(),
    );
    try {
      await onSend(output);
      textEditingController.clear();
      _imageFiles.clear();
    } catch (e) {
      Logger().e('Error occurred: $e');
    }
    _isSending = false;
  }

  // actions - images

  @action
  Future<void> pickImage({
    required ImageSource source,
  }) async {
    if (_isSending) {
      return;
    }
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final updated = _imageFiles.toList();
      updated.add(image);
      _imageFiles = ObservableList<XFile>.of(updated);
    }
  }

  @action
  Future<void> removeImage({
    required XFile image,
  }) async {
    if (_isSending) {
      return;
    }
    final updated = _imageFiles.toList();
    updated.remove(image);
    _imageFiles = ObservableList<XFile>.of(updated);
  }

  // public

  bool isMessageFromCurrentUser(ModelBaseMessage message) {
    return message.userId == _currentUser?.id;
  }
}
