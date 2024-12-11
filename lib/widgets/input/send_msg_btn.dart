import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat/simple_chat.dart';

class SendMsgBtn extends StatelessWidget {
  final bool isSending;
  final bool isDisabled;
  final void Function()? onTap;
  final double size;
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
