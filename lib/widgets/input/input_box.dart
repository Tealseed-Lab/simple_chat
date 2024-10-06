import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:easy_chat/widgets/input/send_msg_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputBoxOutput {
  final String? message;
  InputBoxOutput({
    required this.message,
  });
}

class InputBox extends StatefulWidget {
  final Function(InputBoxOutput output) onSend;

  const InputBox({
    super.key,
    required this.onSend,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController();

  final textFieldStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    height: 1.5,
  );
  final textFieldHorizontalPadding = 0.0;
  final cursorWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const inputBoxHeight = 40.0;
    const inputBoxHorizontalMargin = 16.0;
    const cameraIconWidth = 24.0;
    const cameraIconRightPadding = 16.0;
    const albumIconWidth = 24.0;
    const albumIconRightPadding = 16.0;
    const sendMsgBtnWidth = 32.0;
    const sendMsgBtnRightPadding = 4.0;
    const buttonBoxWidth = cameraIconWidth +
        albumIconWidth +
        sendMsgBtnWidth +
        cameraIconRightPadding +
        albumIconRightPadding +
        sendMsgBtnRightPadding;
    final textFieldMinWidth = MediaQuery.of(context).size.width - inputBoxHorizontalMargin * 2 - buttonBoxWidth;
    return Container(
      padding: EdgeInsets.only(
        left: inputBoxHorizontalMargin,
        right: inputBoxHorizontalMargin,
        top: 8.0,
        bottom: 8.0 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: context.coloredTheme.inputBoxColor,
        border: Border(
          top: BorderSide(
            color: const Color(0xFF3C3C43).withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(inputBoxHeight / 2),
        ),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, outerConstraint) {
            List<Widget> wrapChildren = [
              IntrinsicWidth(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: textFieldMinWidth,
                  ),
                  child: TextField(
                    cursorWidth: cursorWidth,
                    cursorColor: context.coloredTheme.primary,
                    controller: _controller,
                    style: textFieldStyle,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message...',
                      hintStyle: textFieldStyle.copyWith(
                        color: const Color(0xFF3C3C3C).withOpacity(0.3),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: textFieldHorizontalPadding,
                        vertical: 8,
                      ),
                      isDense: true,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ];
            final textFieldWidth = _calculateTextFieldWidth(context) + 8;
            bool isAloneInRow = textFieldWidth > textFieldMinWidth;
            final buttonBox = Container(
              width: buttonBoxWidth,
              height: inputBoxHeight,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: cameraIconRightPadding),
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/svg/input/camera.svg',
                        package: 'easy_chat',
                        width: cameraIconWidth,
                        height: cameraIconWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: albumIconRightPadding),
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/svg/input/album.svg',
                        package: 'easy_chat',
                        width: albumIconWidth,
                        height: albumIconWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: sendMsgBtnRightPadding),
                    child: SendMsgBtn(
                      size: sendMsgBtnWidth,
                      onTap: () {
                        _controller.clear();
                        widget.onSend(
                          InputBoxOutput(
                            message: _controller.text,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
            if (isAloneInRow) {
              wrapChildren.add(
                Align(
                  alignment: Alignment.bottomRight,
                  child: buttonBox,
                ),
              );
            } else {
              wrapChildren.add(buttonBox);
            }
            return SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 0,
                runSpacing: 0,
                children: wrapChildren,
              ),
            );
          },
        ),
      ),
    );
  }

  double _calculateTextFieldWidth(BuildContext context) {
    final text = _controller.text;
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: DefaultTextStyle.of(context).style.merge(textFieldStyle),
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width + textFieldHorizontalPadding * 2; // Add padding to account for margins
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
