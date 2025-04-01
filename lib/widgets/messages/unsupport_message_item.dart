import 'package:flutter/material.dart';
import 'package:simple_chat/widgets/messages/message_bubble.dart';

/// The unsupport message item for the chat.
class UnsupportMessageItem extends StatelessWidget {
  /// The flag for the message from the current user.
  final bool isCurrentUser;

  /// The constructor for the unsupport message item.
  const UnsupportMessageItem({super.key, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
      isCurrentUser: isCurrentUser,
      child: const Text(
        '[Unsupported message]',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    );
  }
}
