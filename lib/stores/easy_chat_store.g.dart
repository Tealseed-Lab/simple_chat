// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy_chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EasyChatStore on EasyChatStoreBase, Store {
  late final _$_messagesAtom =
      Atom(name: 'EasyChatStoreBase._messages', context: context);

  ObservableList<ModelBaseMessage> get messages {
    _$_messagesAtom.reportRead();
    return super._messages;
  }

  @override
  ObservableList<ModelBaseMessage> get _messages => messages;

  @override
  set _messages(ObservableList<ModelBaseMessage> value) {
    _$_messagesAtom.reportWrite(value, super._messages, () {
      super._messages = value;
    });
  }

  late final _$_usersAtom =
      Atom(name: 'EasyChatStoreBase._users', context: context);

  ObservableMap<String, ModelBaseUser> get users {
    _$_usersAtom.reportRead();
    return super._users;
  }

  @override
  ObservableMap<String, ModelBaseUser> get _users => users;

  @override
  set _users(ObservableMap<String, ModelBaseUser> value) {
    _$_usersAtom.reportWrite(value, super._users, () {
      super._users = value;
    });
  }

  late final _$_currentUserAtom =
      Atom(name: 'EasyChatStoreBase._currentUser', context: context);

  ModelBaseUser? get currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  ModelBaseUser? get _currentUser => currentUser;

  @override
  set _currentUser(ModelBaseUser? value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  late final _$addMessageAsyncAction =
      AsyncAction('EasyChatStoreBase.addMessage', context: context);

  @override
  Future<void> addMessage(ModelBaseMessage message) {
    return _$addMessageAsyncAction.run(() => super.addMessage(message));
  }

  late final _$addMessagesAsyncAction =
      AsyncAction('EasyChatStoreBase.addMessages', context: context);

  @override
  Future<void> addMessages(List<ModelBaseMessage> messages) {
    return _$addMessagesAsyncAction.run(() => super.addMessages(messages));
  }

  late final _$addUserAsyncAction =
      AsyncAction('EasyChatStoreBase.addUser', context: context);

  @override
  Future<void> addUser(ModelBaseUser user) {
    return _$addUserAsyncAction.run(() => super.addUser(user));
  }

  late final _$addUsersAsyncAction =
      AsyncAction('EasyChatStoreBase.addUsers', context: context);

  @override
  Future<void> addUsers(List<ModelBaseUser> users) {
    return _$addUsersAsyncAction.run(() => super.addUsers(users));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
