// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on ChatStoreBase, Store {
  Computed<bool>? _$reachImageSelectionLimitComputed;

  @override
  bool get reachImageSelectionLimit => (_$reachImageSelectionLimitComputed ??=
          Computed<bool>(() => super.reachImageSelectionLimit,
              name: 'ChatStoreBase.reachImageSelectionLimit'))
      .value;

  late final _$_messagesAtom =
      Atom(name: 'ChatStoreBase._messages', context: context);

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
      Atom(name: 'ChatStoreBase._users', context: context);

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
      Atom(name: 'ChatStoreBase._currentUser', context: context);

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

  late final _$_imageFilesAtom =
      Atom(name: 'ChatStoreBase._imageFiles', context: context);

  ObservableList<XFile> get imageFiles {
    _$_imageFilesAtom.reportRead();
    return super._imageFiles;
  }

  @override
  ObservableList<XFile> get _imageFiles => imageFiles;

  @override
  set _imageFiles(ObservableList<XFile> value) {
    _$_imageFilesAtom.reportWrite(value, super._imageFiles, () {
      super._imageFiles = value;
    });
  }

  late final _$_isSendingAtom =
      Atom(name: 'ChatStoreBase._isSending', context: context);

  bool get isSending {
    _$_isSendingAtom.reportRead();
    return super._isSending;
  }

  @override
  bool get _isSending => isSending;

  @override
  set _isSending(bool value) {
    _$_isSendingAtom.reportWrite(value, super._isSending, () {
      super._isSending = value;
    });
  }

  late final _$addMessageAsyncAction =
      AsyncAction('ChatStoreBase.addMessage', context: context);

  @override
  Future<void> addMessage(
      {required ModelBaseMessage message, bool isInitial = false}) {
    return _$addMessageAsyncAction
        .run(() => super.addMessage(message: message, isInitial: isInitial));
  }

  late final _$addMessagesAsyncAction =
      AsyncAction('ChatStoreBase.addMessages', context: context);

  @override
  Future<void> addMessages(
      {required List<ModelBaseMessage> messages, bool isInitial = false}) {
    return _$addMessagesAsyncAction
        .run(() => super.addMessages(messages: messages, isInitial: isInitial));
  }

  late final _$removeMessageAsyncAction =
      AsyncAction('ChatStoreBase.removeMessage', context: context);

  @override
  Future<void> removeMessage({required ModelBaseMessage message}) {
    return _$removeMessageAsyncAction
        .run(() => super.removeMessage(message: message));
  }

  late final _$removeMessageByIdAsyncAction =
      AsyncAction('ChatStoreBase.removeMessageById', context: context);

  @override
  Future<void> removeMessageById({required String messageId}) {
    return _$removeMessageByIdAsyncAction
        .run(() => super.removeMessageById(messageId: messageId));
  }

  late final _$removeMessagesAsyncAction =
      AsyncAction('ChatStoreBase.removeMessages', context: context);

  @override
  Future<void> removeMessages({required List<ModelBaseMessage> messages}) {
    return _$removeMessagesAsyncAction
        .run(() => super.removeMessages(messages: messages));
  }

  late final _$addUserAsyncAction =
      AsyncAction('ChatStoreBase.addUser', context: context);

  @override
  Future<void> addUser({required ModelBaseUser user}) {
    return _$addUserAsyncAction.run(() => super.addUser(user: user));
  }

  late final _$addUsersAsyncAction =
      AsyncAction('ChatStoreBase.addUsers', context: context);

  @override
  Future<void> addUsers({required List<ModelBaseUser> users}) {
    return _$addUsersAsyncAction.run(() => super.addUsers(users: users));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('ChatStoreBase.sendMessage', context: context);

  @override
  Future<void> sendMessage(
      {required dynamic Function(TealseedChatMessageSendOutput) onSend}) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(onSend: onSend));
  }

  late final _$pickImageAsyncAction =
      AsyncAction('ChatStoreBase.pickImage', context: context);

  @override
  Future<void> pickImage({required ImageSource source}) {
    return _$pickImageAsyncAction.run(() => super.pickImage(source: source));
  }

  late final _$removeImageAsyncAction =
      AsyncAction('ChatStoreBase.removeImage', context: context);

  @override
  Future<void> removeImage({required XFile image}) {
    return _$removeImageAsyncAction.run(() => super.removeImage(image: image));
  }

  @override
  String toString() {
    return '''
reachImageSelectionLimit: ${reachImageSelectionLimit}
    ''';
  }
}
