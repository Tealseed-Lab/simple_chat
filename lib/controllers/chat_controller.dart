import 'package:flutter/material.dart';
import 'package:simple_chat/controllers/chat_scroll_controller.dart';
import 'package:simple_chat/controllers/view_factory.dart';
import 'package:simple_chat/models/loading_indicator_message.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/messages/image_message_item.dart';
import 'package:simple_chat/widgets/messages/loading_indicator_item.dart';
import 'package:simple_chat/widgets/messages/text_message_item.dart';

enum LoadingIndicatorType {
  sendBtnLoading,
  noBlocking,
}

enum MessageAlignment {
  center,
  justified,
}

class ChatConfig {
  final int imageMaxCount;
  final String? inputBoxHintText;
  final String? failedToSendText;
  final String? photoPermissionDeniedText;
  final String? photoPermissionDeniedButtonText;
  final LoadingIndicatorType loadingIndicatorType;
  final bool showUnreadCount;
  final MessageAlignment messageAlignment;
  ChatConfig({
    this.imageMaxCount = 9,
    this.inputBoxHintText,
    this.failedToSendText,
    this.photoPermissionDeniedText,
    this.photoPermissionDeniedButtonText,
    this.loadingIndicatorType = LoadingIndicatorType.sendBtnLoading,
    this.showUnreadCount = false,
    this.messageAlignment = MessageAlignment.center,
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
    viewFactory.register<ModelLoadingIndicatorMessage>(
      (
        BuildContext context, {
        required bool isMessageFromCurrentUser,
        required ModelLoadingIndicatorMessage message,
      }) =>
          LoadingIndicatorItem(
        message: message,
        isMessageFromCurrentUser: isMessageFromCurrentUser,
      ),
    );
  }

  void scrollToBottom() {
    chatScrollController.scrollToBottom();
    store.readAllMessages();
  }
}
