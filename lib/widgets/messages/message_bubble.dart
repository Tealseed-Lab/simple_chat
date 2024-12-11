import 'package:flutter/material.dart';
import 'package:simple_chat/theme/chat_theme.dart';

class MessageBubble extends StatelessWidget {
  final EdgeInsets padding;
  final bool isCurrentUser;
  final Widget? child;
  const MessageBubble({
    super.key,
    required this.isCurrentUser,
    this.padding = const EdgeInsets.all(12),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: padding,
        color: isCurrentUser ? context.coloredTheme.myMessageColor : context.coloredTheme.otherMessageColor,
        child: child,
      ),
    );
  }
}
