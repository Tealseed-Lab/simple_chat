import 'package:easy_chat/controllers/chat_scroll_controller.dart';
import 'package:easy_chat/controllers/easy_chat_action_handler.dart';
import 'package:easy_chat/controllers/view_factory.dart';
import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/messages/text_message_item.dart';
import 'package:flutter/material.dart';

class EasyChatController {
  late final EasyChatStore store;
  final chatScrollController = ChatScrollController();
  final viewFactory = ViewFactory();
  final EasyChatActionHandler? actionHandler;

  EasyChatController({
    this.actionHandler,
  }) {
    store = EasyChatStore(
      chatScrollController,
    );
    viewFactory.register<ModelTextMessage>(
      (
        BuildContext context, {
        required bool isMessageFromCurrentUser,
        required ModelTextMessage message,
      }) =>
          TextMessageItem(
        isMessageFromCurrentUser: isMessageFromCurrentUser,
        textMessage: message,
      ),
    );
  }

  void scrollToBottom() {
    chatScrollController.scrollToBottom();
  }
}
