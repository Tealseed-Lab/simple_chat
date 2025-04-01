import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/messages/message_bubble.dart';

/// The image message item for the chat.
class ImageMessageItem extends StatelessWidget {
  /// The image message.
  final ModelImageMessage imageMessage;

  /// The flag for the message from the current user.
  final bool isMessageFromCurrentUser;

  /// The constructor for the image message item.
  const ImageMessageItem({
    super.key,
    required this.imageMessage,
    required this.isMessageFromCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = imageMessage.imageUrls.firstOrNull;
    Widget? child;
    if (imageUrl != null) {
      if (imageUrl.startsWith('http')) {
        child = Image.network(imageUrl);
      } else {
        child = Image.file(File(imageUrl));
      }
    }
    return MessageBubble(
      padding: EdgeInsets.zero,
      isCurrentUser: isMessageFromCurrentUser,
      child: child,
    );
  }
}
