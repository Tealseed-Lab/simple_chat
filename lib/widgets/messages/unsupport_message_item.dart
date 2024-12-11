import 'package:simple_chat/widgets/messages/message_bubble.dart';
import 'package:flutter/material.dart';

class UnsupportMessageItem extends StatelessWidget {
  final bool isCurrentUser;
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
