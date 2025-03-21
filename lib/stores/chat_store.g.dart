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

  late final _$_isInputBoxFocusedAtom =
      Atom(name: 'ChatStoreBase._isInputBoxFocused', context: context);

  bool get isInputBoxFocused {
    _$_isInputBoxFocusedAtom.reportRead();
    return super._isInputBoxFocused;
  }

  @override
  bool get _isInputBoxFocused => isInputBoxFocused;

  @override
  set _isInputBoxFocused(bool value) {
    _$_isInputBoxFocusedAtom.reportWrite(value, super._isInputBoxFocused, () {
      super._isInputBoxFocused = value;
    });
  }

  late final _$_imageFilesAtom =
      Atom(name: 'ChatStoreBase._imageFiles', context: context);

  ObservableList<AssetImageInfo> get imageFiles {
    _$_imageFilesAtom.reportRead();
    return super._imageFiles;
  }

  @override
  ObservableList<AssetImageInfo> get _imageFiles => imageFiles;

  @override
  set _imageFiles(ObservableList<AssetImageInfo> value) {
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

  late final _$_readSequenceAtom =
      Atom(name: 'ChatStoreBase._readSequence', context: context);

  int get readSequence {
    _$_readSequenceAtom.reportRead();
    return super._readSequence;
  }

  @override
  int get _readSequence => readSequence;

  @override
  set _readSequence(int value) {
    _$_readSequenceAtom.reportWrite(value, super._readSequence, () {
      super._readSequence = value;
    });
  }

  late final _$_hasUnreadMessagesAtom =
      Atom(name: 'ChatStoreBase._hasUnreadMessages', context: context);

  bool get hasUnreadMessages {
    _$_hasUnreadMessagesAtom.reportRead();
    return super._hasUnreadMessages;
  }

  @override
  bool get _hasUnreadMessages => hasUnreadMessages;

  @override
  set _hasUnreadMessages(bool value) {
    _$_hasUnreadMessagesAtom.reportWrite(value, super._hasUnreadMessages, () {
      super._hasUnreadMessages = value;
    });
  }

  late final _$_unreadMessagesCountAtom =
      Atom(name: 'ChatStoreBase._unreadMessagesCount', context: context);

  int get unreadMessagesCount {
    _$_unreadMessagesCountAtom.reportRead();
    return super._unreadMessagesCount;
  }

  @override
  int get _unreadMessagesCount => unreadMessagesCount;

  @override
  set _unreadMessagesCount(int value) {
    _$_unreadMessagesCountAtom.reportWrite(value, super._unreadMessagesCount,
        () {
      super._unreadMessagesCount = value;
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

  late final _$postMessageProcessingAsyncAction =
      AsyncAction('ChatStoreBase.postMessageProcessing', context: context);

  @override
  Future<void> postMessageProcessing(
      {required bool isAtBottom,
      required bool isInitial,
      required List<ModelBaseMessage> newMessages}) {
    return _$postMessageProcessingAsyncAction.run(() => super
        .postMessageProcessing(
            isAtBottom: isAtBottom,
            isInitial: isInitial,
            newMessages: newMessages));
  }

  late final _$readMessageAsyncAction =
      AsyncAction('ChatStoreBase.readMessage', context: context);

  @override
  Future<void> readMessage({required ModelBaseMessage message}) {
    return _$readMessageAsyncAction
        .run(() => super.readMessage(message: message));
  }

  late final _$readAllMessagesAsyncAction =
      AsyncAction('ChatStoreBase.readAllMessages', context: context);

  @override
  Future<void> readAllMessages() {
    return _$readAllMessagesAsyncAction.run(() => super.readAllMessages());
  }

  late final _$updateUnreadStatusAsyncAction =
      AsyncAction('ChatStoreBase.updateUnreadStatus', context: context);

  @override
  Future<void> updateUnreadStatus() {
    return _$updateUnreadStatusAsyncAction
        .run(() => super.updateUnreadStatus());
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

  late final _$clearAllAsyncAction =
      AsyncAction('ChatStoreBase.clearAll', context: context);

  @override
  Future<void> clearAll() {
    return _$clearAllAsyncAction.run(() => super.clearAll());
  }

  late final _$updateSendStatusAsyncAction =
      AsyncAction('ChatStoreBase.updateSendStatus', context: context);

  @override
  Future<void> updateSendStatus(
      {required String messageId, required ModelBaseMessageStatus status}) {
    return _$updateSendStatusAsyncAction.run(
        () => super.updateSendStatus(messageId: messageId, status: status));
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
      {required dynamic Function(ChatMessageSendOutput) onSend}) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(onSend: onSend));
  }

  late final _$takePhotoAsyncAction =
      AsyncAction('ChatStoreBase.takePhoto', context: context);

  @override
  Future<void> takePhoto(BuildContext context) {
    return _$takePhotoAsyncAction.run(() => super.takePhoto(context));
  }

  late final _$pickImageAsyncAction =
      AsyncAction('ChatStoreBase.pickImage', context: context);

  @override
  Future<void> pickImage(BuildContext context) {
    return _$pickImageAsyncAction.run(() => super.pickImage(context));
  }

  late final _$removeImageAsyncAction =
      AsyncAction('ChatStoreBase.removeImage', context: context);

  @override
  Future<void> removeImage({required AssetImageInfo image}) {
    return _$removeImageAsyncAction.run(() => super.removeImage(image: image));
  }

  late final _$showReplyGeneratingIndicatorAsyncAction = AsyncAction(
      'ChatStoreBase.showReplyGeneratingIndicator',
      context: context);

  @override
  Future<void> showReplyGeneratingIndicator() {
    return _$showReplyGeneratingIndicatorAsyncAction
        .run(() => super.showReplyGeneratingIndicator());
  }

  late final _$hideReplyGeneratingIndicatorAsyncAction = AsyncAction(
      'ChatStoreBase.hideReplyGeneratingIndicator',
      context: context);

  @override
  Future<void> hideReplyGeneratingIndicator() {
    return _$hideReplyGeneratingIndicatorAsyncAction
        .run(() => super.hideReplyGeneratingIndicator());
  }

  @override
  String toString() {
    return '''
reachImageSelectionLimit: ${reachImageSelectionLimit}
    ''';
  }
}
