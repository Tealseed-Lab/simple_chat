import 'dart:io';

import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/messages/message_bubble.dart';
import 'package:flutter/material.dart';

class ImageMessageItem extends StatelessWidget {
  final ModelImageMessage imageMessage;
  final bool isMessageFromCurrentUser;

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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 120,
          maxHeight: 200,
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: child,
        ),
      ),
    );
  }
}
