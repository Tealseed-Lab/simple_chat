import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:easy_chat/widgets/input/input_box_image_item.dart';
import 'package:easy_chat/widgets/input/input_box_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final List<XFile> imageFiles;
  final Function() onSend;
  final Function() onCameraTap;
  final Function() onAlbumTap;
  final Function(XFile) onImageTap;
  final Function(XFile) onImageRemove;

  const InputBox({
    super.key,
    required this.controller,
    required this.imageFiles,
    required this.onSend,
    required this.onCameraTap,
    required this.onAlbumTap,
    required this.onImageTap,
    required this.onImageRemove,
  });

  final inputBoxHorizontalMargin = 16.0;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputBoxTextField(
            inputBoxHorizontalMargin: inputBoxHorizontalMargin,
            controller: controller,
            imageFiles: imageFiles,
            onSend: onSend,
            onCameraTap: onCameraTap,
            onAlbumTap: onAlbumTap,
          ),
          if (imageFiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                clipBehavior: Clip.none,
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                children: [
                  for (var imageFile in imageFiles)
                    InputBoxImageItem(
                      imageFile: imageFile,
                      onTap: onImageTap,
                      onRemove: onImageRemove,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
