import 'package:example/custom_message.dart';
import 'package:flutter/material.dart';

class CustomMessageView extends StatelessWidget {
  final CustomMessage message;
  final bool isMessageFromCurrentUser;
  const CustomMessageView({
    super.key,
    required this.message,
    required this.isMessageFromCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      color: Colors.red,
      alignment: Alignment.center,
      child: const Text('this is a custom message'),
    );
  }
}
