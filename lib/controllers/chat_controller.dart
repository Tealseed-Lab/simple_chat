import 'package:flutter/material.dart';
import 'package:simple_chat/controllers/chat_scroll_controller.dart';
import 'package:simple_chat/controllers/view_factory.dart';
import 'package:simple_chat/models/loading_indicator_message.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/messages/image_message_item.dart';
import 'package:simple_chat/widgets/messages/loading_indicator_item.dart';
import 'package:simple_chat/widgets/messages/text_message_item.dart';

/// The type of the loading indicator.
enum LoadingIndicatorType {
  /// The loading indicator type for the send button.
  sendBtnLoading,

  /// The loading indicator type for the no blocking.
  noBlocking,
}

/// The alignment of the message.
enum MessageAlignment {
  /// The alignment of the message for the center.
  center,

  /// The alignment of the message for the justified.
  justified,
}

/// The config for the chat.
class ChatConfig {
  /// The max count of the image.
  final int imageMaxCount;

  /// The hint text for the input box.
  final String? inputBoxHintText;

  /// The text for the failed to send.
  final String? failedToSendText;

  /// The text for the photo permission denied.
  final String? photoPermissionDeniedText;

  /// The text for the photo permission denied button.
  final String? photoPermissionDeniedButtonText;

  /// The type of the loading indicator.
  final LoadingIndicatorType loadingIndicatorType;

  /// The flag for the show unread count.
  final bool showUnreadCount;

  /// The alignment of the message.
  final MessageAlignment messageAlignment;

  /// The constructor of the chat config.
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

/// The controller for the chat.
class ChatController {
  /// The store for the chat.
  late final ChatStore store;

  /// The scroll controller for the chat.
  final chatScrollController = ChatScrollController();

  /// The view factory for the chat.
  final viewFactory = ViewFactory();

  /// The action handler for the chat.
  final ChatActionHandler? actionHandler;

  /// The config for the chat.
  late final ChatConfig config;

  /// The constructor of the chat controller.
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

  /// The method for the scroll to bottom.
  void scrollToBottom() {
    chatScrollController.scrollToBottom();
    store.readAllMessages();
  }
}
