import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isCurrentUser;
  final Widget? child;
  const MessageBubble({
    super.key,
    required this.isCurrentUser,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isCurrentUser ? context.coloredTheme.myMessageColor : context.coloredTheme.otherMessageColor,
      ),
      child: child,
    );
  }
}
