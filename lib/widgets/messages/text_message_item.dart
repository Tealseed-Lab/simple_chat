import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/messages/message_bubble.dart';
import 'package:flutter/material.dart';

class TextMessageItem extends StatelessWidget {
  final ModelTextMessage textMessage;
  final bool isMessageFromCurrentUser;

  const TextMessageItem({
    super.key,
    required this.textMessage,
    required this.isMessageFromCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
      isCurrentUser: isMessageFromCurrentUser,
      child: Text(
        textMessage.text,
        maxLines: null,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }
}
