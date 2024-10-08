import 'package:easy_chat/controllers/chat_scroll_controller.dart';
import 'package:easy_chat/controllers/view_factory.dart';
import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/messages/image_message_item.dart';
import 'package:easy_chat/widgets/messages/text_message_item.dart';
import 'package:flutter/material.dart';

class EasyChatConfig {
  final int imageMaxCount;
  final String? inputBoxHintText;
  EasyChatConfig({
    this.imageMaxCount = 9,
    this.inputBoxHintText,
  });
}

class EasyChatController {
  late final EasyChatStore store;
  final chatScrollController = ChatScrollController();
  final viewFactory = ViewFactory();
  final EasyChatActionHandler? actionHandler;
  late final EasyChatConfig config;
  EasyChatController({
    this.actionHandler,
    EasyChatConfig? config,
  }) {
    this.config = config ?? EasyChatConfig();
    store = EasyChatStore(
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
