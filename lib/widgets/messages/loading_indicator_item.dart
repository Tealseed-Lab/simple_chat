import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_chat/models/loading_indicator_message.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/messages/message_bubble.dart';

/// The loading indicator item for the chat.
class LoadingIndicatorItem extends StatelessWidget {
  /// The message.
  final ModelLoadingIndicatorMessage message;

  /// The flag for the message from the current user.
  final bool isMessageFromCurrentUser;

  /// The constructor for the loading indicator item.
  const LoadingIndicatorItem({
    super.key,
    required this.message,
    required this.isMessageFromCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
      isCurrentUser: isMessageFromCurrentUser,
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 20,
        width: 40,
        child: Lottie.asset(
          'assets/lottie/speech_loading.json',
          repeat: true,
          package: kChatPackage,
        ),
      ),
    );
  }
}
