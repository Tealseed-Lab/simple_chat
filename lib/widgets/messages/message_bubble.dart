import 'package:flutter/material.dart';
import 'package:simple_chat/theme/chat_theme.dart';

/// The message bubble for the chat.
class MessageBubble extends StatelessWidget {
  /// The padding of the message bubble.
  final EdgeInsets padding;

  /// The flag for the message from the current user.
  final bool isCurrentUser;

  /// The child of the message bubble.
  final Widget? child;

  /// The constructor for the message bubble.
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
        color: isCurrentUser
            ? context.coloredTheme.myMessageColor
            : context.coloredTheme.otherMessageColor,
        child: child,
      ),
    );
  }
}
