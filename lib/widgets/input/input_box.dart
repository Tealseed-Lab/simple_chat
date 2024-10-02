import 'package:easy_chat/models/user.dart';
import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputBox extends StatefulWidget {
  final Function(String) onSend;

  const InputBox({
    super.key,
    required this.onSend,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const inputBoxHeight = 40.0;
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
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
        height: inputBoxHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(inputBoxHeight / 2),
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF3C3C3C).withOpacity(0.3),
                    fontSize: 16,
                    height: 1.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/svg/input/camera.svg',
                  package: 'easy_chat',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/svg/input/album.svg',
                  package: 'easy_chat',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/svg/input/send.svg',
                  package: 'easy_chat',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
