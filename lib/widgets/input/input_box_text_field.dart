import 'package:easy_chat/easy_chat.dart';
import 'package:easy_chat/widgets/input/send_msg_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class InputBoxTextField extends StatefulWidget {
  final double inputBoxHorizontalMargin;

  final EasyChatController controller;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function() onSend;
  final Function() onCameraTap;
  final Function() onAlbumTap;

  const InputBoxTextField({
    super.key,
    this.inputBoxHorizontalMargin = 16.0,
    required this.controller,
    required this.textEditingController,
    required this.focusNode,
    required this.onSend,
    required this.onCameraTap,
    required this.onAlbumTap,
  });

  @override
  State<InputBoxTextField> createState() => _InputBoxTextFieldState();
}

class _InputBoxTextFieldState extends State<InputBoxTextField> {
  late final store = widget.controller.store;
  final textFieldStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    height: 1.5,
  );
  final textFieldHorizontalPadding = 16.0;
  final cursorWidth = 2.0;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const inputBoxHeight = 40.0;
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
    final textFieldMinWidth = MediaQuery.of(context).size.width - widget.inputBoxHorizontalMargin * 2 - buttonBoxWidth;
    return Container(
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
                  controller: widget.textEditingController,
                  style: textFieldStyle,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.controller.config.inputBoxHintText,
                    hintStyle: textFieldStyle.copyWith(
                      color: const Color(0xFF3C3C3C).withOpacity(0.3),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: textFieldHorizontalPadding,
                      vertical: 8,
                    ),
                    isDense: true,
                  ),
                  focusNode: widget.focusNode,
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
                  child: Observer(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        if (store.isSending || store.reachImageSelectionLimit) {
                          return;
                        }
                        widget.onCameraTap.call();
                      },
                      child: SvgPicture.asset(
                        'assets/svg/input/camera.svg',
                        package: 'easy_chat',
                        width: cameraIconWidth,
                        height: cameraIconWidth,
                        colorFilter: ColorFilter.mode(
                          store.isSending || store.reachImageSelectionLimit
                              ? Colors.black.withOpacity(0.3)
                              : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: albumIconRightPadding),
                  child: Observer(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        if (store.isSending || store.reachImageSelectionLimit) {
                          return;
                        }
                        widget.onAlbumTap.call();
                      },
                      child: SvgPicture.asset(
                        'assets/svg/input/album.svg',
                        package: 'easy_chat',
                        width: albumIconWidth,
                        height: albumIconWidth,
                        colorFilter: ColorFilter.mode(
                          store.isSending || store.reachImageSelectionLimit
                              ? Colors.black.withOpacity(0.3)
                              : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: sendMsgBtnRightPadding),
                  child: Observer(
                    builder: (context) => SendMsgBtn(
                      size: sendMsgBtnWidth,
                      isSending: store.isSending,
                      isDisabled:
                          widget.textEditingController.text.isEmpty && widget.controller.store.imageFiles.isEmpty,
                      onTap: () {
                        if (store.isSending) {
                          return;
                        }
                        widget.onSend.call();
                      },
                    ),
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
    );
  }

  double _calculateTextFieldWidth(BuildContext context) {
    final text = widget.textEditingController.text;
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

    return textPainter.size.width + textFieldHorizontalPadding * 2 + cursorWidth;
  }
}
