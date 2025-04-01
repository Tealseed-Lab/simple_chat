import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:simple_chat/widgets/input/input_box_image_item.dart';
import 'package:simple_chat/widgets/input/input_box_text_field.dart';

/// The input box for the chat.
class InputBox extends StatelessWidget {
  /// The controller for the chat.
  final ChatController controller;

  /// The text editing controller.
  final TextEditingController textEditingController;

  /// The focus node.
  final FocusNode focusNode;

  /// The on send callback.
  final Function() onSend;

  /// The on camera tap callback.
  final Function() onCameraTap;

  /// The on album tap callback.
  final Function() onAlbumTap;

  /// The on image tap callback.
  final Function(AssetImageInfo) onImageTap;

  /// The on image remove callback.
  final Function(AssetImageInfo) onImageRemove;

  /// The store for the chat.
  late final ChatStore store;

  /// The constructor for the input box.
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

  /// The input box horizontal margin.
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
            color: const Color(0xFF3C3C43).withValues(alpha: 0.1),
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
