import 'package:easy_chat/controllers/view_factory.dart';
import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/messages/text_message_item.dart';
import 'package:flutter/material.dart';

class EasyChatController {
  final store = EasyChatStore();
  final viewFactory = ViewFactory();

  EasyChatController() {
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
}
