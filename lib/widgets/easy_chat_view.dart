import 'package:easy_chat/controllers/easy_chat_controller.dart';
import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:easy_chat/widgets/input/input_box.dart';
import 'package:easy_chat/widgets/messages/unsupport_message_item.dart';
import 'package:easy_chat/widgets/users/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class EasyChatView extends StatefulWidget {
  late final EasyChatThemeData theme;
  late final EasyChatController controller;
  EasyChatView({
    super.key,
    EasyChatThemeData? theme,
    EasyChatController? controller,
  }) {
    this.theme = theme ??
        EasyChatThemeData(
          light: EasyChatColorThemeData(),
          dark: EasyChatColorThemeData(),
        );
    this.controller = controller ?? EasyChatController();
  }
  @override
  State<StatefulWidget> createState() {
    return _EasyChatViewState();
  }
}

class _EasyChatViewState extends State<EasyChatView> {
  late final store = widget.controller.store;
  @override
  void initState() {
    super.initState();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return EasyChatTheme(
      data: EasyChatThemeData(
        light: widget.theme.light,
        dark: widget.theme.dark,
      ),
      child: Builder(
        builder: (context) => Container(
          color: context.coloredTheme.backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _dismissKeyboard,
                  child: _buildMessageList(context),
                ),
              ),
              InputBox(
                controller: widget.controller,
                textEditingController: store.textEditingController,
                focusNode: store.focusNode,
                onSend: () {
                  store.sendMessage(
                    onSend: (output) async {
                      await widget.controller.actionHandler?.onSendMessage
                          ?.call(output);
                    },
                  );
                },
                onCameraTap: () {
                  if (store.imageFiles.length >=
                      widget.controller.config.imageMaxCount) {
                    return;
                  }
                  store.pickImage(source: ImageSource.camera);
                },
                onAlbumTap: () {
                  if (store.imageFiles.length >=
                      widget.controller.config.imageMaxCount) {
                    return;
                  }
                  store.pickImage(source: ImageSource.gallery);
                },
                onImageTap: (imageFile) {},
                onImageRemove: (imageFile) {
                  store.removeImage(image: imageFile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return Observer(
      builder: (context) => ListView.separated(
        controller: widget.controller.chatScrollController.controller,
        padding: context.layoutTheme.chatViewPadding,
        cacheExtent: 1000,
        separatorBuilder: (context, index) {
          final currentMessage = store.messages[index];
          final nextMessage = index + 1 < store.messages.length
              ? store.messages[index + 1]
              : null;
          final isSameUser = nextMessage != null &&
              currentMessage.userId == nextMessage.userId;
          return SizedBox(height: isSameUser ? 4 : 16);
        },
        itemCount: store.messages.length,
        itemBuilder: (context, index) {
          return Observer(
            builder: (context) {
              final message = store.messages[index];
              final previousMessage =
                  index > 0 ? store.messages[index - 1] : null;
              final isMessageFromCurrentUser =
                  store.isMessageFromCurrentUser(message);
              final isSameUser = previousMessage != null &&
                  message.userId == previousMessage.userId;

              final builder = widget.controller.viewFactory.buildFor(
                context,
                message: message,
                isMessageFromCurrentUser: isMessageFromCurrentUser,
              );
              final messageItem = builder ??
                  UnsupportMessageItem(isCurrentUser: isMessageFromCurrentUser);
              final user = store.users[message.userId];
              final userAvatar = isSameUser
                  ? SizedBox(width: context.layoutTheme.userAvatarSize)
                  : UserAvatar(user: user);

              // Wrap messageItem with Flexible widget
              final flexibleMessageItem = Flexible(
                child: messageItem,
              );

              if (isMessageFromCurrentUser) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    flexibleMessageItem,
                    const SizedBox(width: 8),
                    userAvatar,
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userAvatar,
                    const SizedBox(width: 8),
                    flexibleMessageItem,
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
