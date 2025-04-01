import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat/simple_chat.dart';

/// The send message button for the chat.
class SendMsgBtn extends StatelessWidget {
  /// The is sending flag.
  final bool isSending;

  /// The is disabled flag.
  final bool isDisabled;

  /// The on tap callback.
  final void Function()? onTap;

  /// The size of the button.
  final double size;

  /// The constructor for the send message button.
  const SendMsgBtn({
    super.key,
    this.onTap,
    this.isDisabled = false,
    this.isSending = false,
    this.size = 32,
  });
  @override
  Widget build(BuildContext context) {
    Widget view;
    if (isSending) {
      view = Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(4),
        child: CircularProgressIndicator(
          color: context.coloredTheme.primary,
        ),
      );
    } else if (isDisabled) {
      view = SvgPicture.asset(
        'assets/svg/input/send_disabled.svg',
        package: kChatPackage,
        width: size,
        height: size,
      );
    } else {
      view = SvgPicture.asset(
        'assets/svg/input/send.svg',
        package: kChatPackage,
        width: size,
        height: size,
      );
    }
    return GestureDetector(
      onTap: () {
        if (isDisabled) return;
        onTap?.call();
      },
      child: view,
    );
  }
}
