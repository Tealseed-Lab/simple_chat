import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tealseed_chat/controllers/chat_controller.dart';
import 'package:tealseed_chat/theme/chat_theme.dart';
import 'package:tealseed_chat/widgets/input/input_box.dart';
import 'package:tealseed_chat/widgets/messages/unsupport_message_item.dart';
import 'package:tealseed_chat/widgets/users/user_avatar.dart';

class ChatView extends StatefulWidget {
  late final ChatThemeData theme;
  late final ChatController controller;
  ChatView({
    super.key,
    ChatThemeData? theme,
    ChatController? controller,
  }) {
    this.theme = theme ??
        ChatThemeData(
          light: ChatColorThemeData(),
          dark: ChatColorThemeData(),
        );
    this.controller = controller ?? ChatController();
  }
  @override
  State<StatefulWidget> createState() {
    return _ChatViewState();
  }
}

class _ChatViewState extends State<ChatView> {
  late final store = widget.controller.store;
  @override
  void initState() {
    super.initState();
  }

  void _dismissKeyboard() {
    store.focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final view = ChatTheme(
      data: ChatThemeData(
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
                      await widget.controller.actionHandler?.onSendMessage?.call(output);
                    },
                  );
                },
                onCameraTap: () async {
                  if (store.imageFiles.length >= widget.controller.config.imageMaxCount) {
                    return;
                  }
                  await store.pickImage(source: ImageSource.camera);
                  store.focusNode.requestFocus();
                },
                onAlbumTap: () async {
                  if (store.imageFiles.length >= widget.controller.config.imageMaxCount) {
                    return;
                  }
                  _dismissKeyboard();
                  await store.pickImage(source: ImageSource.gallery);
                  store.focusNode.requestFocus();
                },
                onImageTap: (imageFile) {
                  widget.controller.actionHandler?.onImageThumbnailTap?.call(imageFile);
                },
                onImageRemove: (imageFile) {
                  store.removeImage(image: imageFile);
                },
              ),
            ],
          ),
        ),
      ),
    );
    return view;
  }

  Widget _buildMessageList(BuildContext context) {
    return Observer(
      builder: (context) => Align(
        alignment: Alignment.topCenter,
        child: ListView.separated(
          reverse: true,
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: widget.controller.chatScrollController.controller,
          padding: context.layoutTheme.chatViewPadding,
          cacheExtent: 1000,
          separatorBuilder: (context, index) {
            final currentMessage = store.messages[index];
            final previousMessage = index + 1 < store.messages.length ? store.messages[index + 1] : null;
            final isSameUser = previousMessage != null && currentMessage.userId == previousMessage.userId;
            return SizedBox(height: isSameUser && !currentMessage.forceNewBlock ? 4 : 16);
          },
          itemCount: store.messages.length,
          itemBuilder: (context, index) {
            return Observer(
              builder: (context) {
                final message = store.messages[index];
                final previousMessage = index + 1 < store.messages.length ? store.messages[index + 1] : null;
                final isMessageFromCurrentUser = store.isMessageFromCurrentUser(message);
                final isSameUser = previousMessage != null && message.userId == previousMessage.userId;

                final builder = widget.controller.viewFactory.buildFor(
                  context,
                  message: message,
                  isMessageFromCurrentUser: isMessageFromCurrentUser,
                );
                final messageItem = builder ?? UnsupportMessageItem(isCurrentUser: isMessageFromCurrentUser);
                final user = store.users[message.userId];
                final userAvatar = isSameUser && !message.forceNewBlock
                    ? SizedBox(width: context.layoutTheme.userAvatarSize)
                    : UserAvatar(
                        user: user,
                        onTap: () {
                          widget.controller.actionHandler?.onUserAvatarTap?.call(user);
                        },
                      );
                const avatarMessageSpacing = 8.0;

                // Wrap messageItem with Flexible widget
                final flexibleMessageItem = Flexible(
                  child: GestureDetector(
                    onTap: () => widget.controller.actionHandler?.onMessageTap?.call(message),
                    child: messageItem,
                  ),
                );

                if (isMessageFromCurrentUser) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: avatarMessageSpacing + context.layoutTheme.userAvatarSize),
                      flexibleMessageItem,
                      const SizedBox(width: avatarMessageSpacing),
                      userAvatar,
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userAvatar,
                      const SizedBox(width: avatarMessageSpacing),
                      flexibleMessageItem,
                      SizedBox(width: avatarMessageSpacing + context.layoutTheme.userAvatarSize),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
