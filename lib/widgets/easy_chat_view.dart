import 'package:easy_chat/controllers/easy_chat_controller.dart';
import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:easy_chat/widgets/input/input_box.dart';
import 'package:easy_chat/widgets/messages/unsupport_message_item.dart';
import 'package:easy_chat/widgets/users/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
    widget.controller.chatScrollController.controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    // check if it's a user initiated scroll
    if (widget.controller.chatScrollController.controller.position.userScrollDirection != ScrollDirection.idle) {
      _dismissKeyboard();
    }
  }

  void _dismissKeyboard() {
    store.focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final view = EasyChatTheme(
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
                      await widget.controller.actionHandler?.onSendMessage?.call(output);
                    },
                  );
                },
                onCameraTap: () {
                  if (store.imageFiles.length >= widget.controller.config.imageMaxCount) {
                    return;
                  }
                  store.pickImage(source: ImageSource.camera);
                },
                onAlbumTap: () {
                  if (store.imageFiles.length >= widget.controller.config.imageMaxCount) {
                    return;
                  }
                  store.pickImage(source: ImageSource.gallery);
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
