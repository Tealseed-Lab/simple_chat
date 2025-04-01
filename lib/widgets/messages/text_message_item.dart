import 'package:flutter/material.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/messages/message_bubble.dart';

/// The text message item for the chat.
class TextMessageItem extends StatelessWidget {
  /// The text message.
  final ModelTextMessage textMessage;

  /// The flag for the message from the current user.
  final bool isMessageFromCurrentUser;

  /// The constructor for the text message item.
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
