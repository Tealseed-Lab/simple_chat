import 'package:easy_chat/controllers/chat_scroll_controller.dart';
import 'package:easy_chat/models/base_message.dart';
import 'package:easy_chat/models/base_user.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'easy_chat_store.g.dart';

class EasyChatStore = EasyChatStoreBase with _$EasyChatStore;

abstract class EasyChatStoreBase with Store {
  final ChatScrollController chatScrollController;

  EasyChatStoreBase(
    this.chatScrollController,
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

  // actions

  @action
  Future<void> addMessage({
    required ModelBaseMessage message,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    _messages.add(message);
    if (!isInitial && isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    }
  }

  @action
  Future<void> addMessages({
    required List<ModelBaseMessage> messages,
    bool isInitial = false,
  }) async {
    final isAtBottom = chatScrollController.isAtBottom();
    _messages.addAll(messages);
    if (!isInitial && isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.scrollToBottom();
      });
    }
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

  // public

  bool isMessageFromCurrentUser(ModelBaseMessage message) {
    return message.userId == _currentUser?.id;
  }

  // private
}
