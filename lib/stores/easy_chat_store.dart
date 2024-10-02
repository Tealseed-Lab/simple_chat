import 'package:easy_chat/controllers/chat_scroll_controller.dart';
import 'package:easy_chat/models/base_message.dart';
import 'package:easy_chat/models/base_user.dart';
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
  Future<void> addMessage(ModelBaseMessage message) async {
    _messages.add(message);
  }

  @action
  Future<void> addMessages(List<ModelBaseMessage> messages) async {
    _messages.addAll(messages);
  }

  @action
  Future<void> addUser(ModelBaseUser user) async {
    _users[user.id] = user;
    if (user.isCurrentUser) {
      _currentUser = user;
    }
  }

  @action
  Future<void> addUsers(List<ModelBaseUser> users) async {
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
