import 'package:flutter/material.dart';
import 'package:tealseed_chat/controllers/chat_scroll_controller.dart';
import 'package:tealseed_chat/controllers/view_factory.dart';
import 'package:tealseed_chat/tealseed_chat.dart';
import 'package:tealseed_chat/widgets/messages/image_message_item.dart';
import 'package:tealseed_chat/widgets/messages/text_message_item.dart';

class ChatConfig {
  final int imageMaxCount;
  final String? inputBoxHintText;
  ChatConfig({
    this.imageMaxCount = 9,
    this.inputBoxHintText,
  });
}

class ChatController {
  late final ChatStore store;
  final chatScrollController = ChatScrollController();
  final viewFactory = ViewFactory();
  final ChatActionHandler? actionHandler;
  late final ChatConfig config;
  ChatController({
    this.actionHandler,
    ChatConfig? config,
  }) {
    this.config = config ?? ChatConfig();
    store = ChatStore(
      chatScrollController,
      this.config,
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
    viewFactory.register<ModelImageMessage>(
      (
        BuildContext context, {
        required bool isMessageFromCurrentUser,
        required ModelImageMessage message,
      }) =>
          ImageMessageItem(
        isMessageFromCurrentUser: isMessageFromCurrentUser,
        imageMessage: message,
      ),
    );
  }

  void scrollToBottom() {
    chatScrollController.scrollToBottom();
  }
}
