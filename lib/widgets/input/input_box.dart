import 'package:easy_asset_picker/picker/models/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/input/input_box_image_item.dart';
import 'package:simple_chat/widgets/input/input_box_text_field.dart';

class InputBox extends StatelessWidget {
  final ChatController controller;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function() onSend;
  final Function() onCameraTap;
  final Function() onAlbumTap;
  final Function(AssetImageInfo) onImageTap;
  final Function(AssetImageInfo) onImageRemove;

  late final ChatStore store;

  InputBox({
    super.key,
    required this.controller,
    required this.textEditingController,
    required this.focusNode,
    required this.onSend,
    required this.onCameraTap,
    required this.onAlbumTap,
    required this.onImageTap,
    required this.onImageRemove,
  }) {
    store = controller.store;
  }

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
            controller: controller,
            inputBoxHorizontalMargin: inputBoxHorizontalMargin,
            textEditingController: textEditingController,
            focusNode: focusNode,
            onSend: onSend,
            onCameraTap: onCameraTap,
            onAlbumTap: onAlbumTap,
          ),
          Observer(
            builder: (context) {
              final imageFiles = store.imageFiles;
              if (imageFiles.isNotEmpty) {
                return Padding(
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
                          disabled: store.isSending,
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
