import 'package:easy_chat/controllers/easy_chat_controller.dart';
import 'package:easy_chat/theme/easy_chat_theme.dart';
import 'package:easy_chat/widgets/input/input_box.dart';
import 'package:easy_chat/widgets/messages/unsupport_message_item.dart';
import 'package:easy_chat/widgets/users/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EasyChatView extends StatefulWidget {
  final EasyChatThemeData theme;
  late final EasyChatController controller;
  EasyChatView({
    super.key,
    required this.theme,
    EasyChatController? controller,
  }) {
    this.controller = controller ?? EasyChatController();
  }
  @override
  State<StatefulWidget> createState() {
    return _EasyChatViewState();
  }
}

class _EasyChatViewState extends State<EasyChatView> {
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
              Expanded(child: _buildMessageList(context)),
              InputBox(onSend: (text) {}),
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
        separatorBuilder: (context, index) {
          final currentMessage = widget.controller.store.messages[index];
          final nextMessage =
              index + 1 < widget.controller.store.messages.length ? widget.controller.store.messages[index + 1] : null;
          final isSameUser = nextMessage != null && currentMessage.userId == nextMessage.userId;
          return SizedBox(height: isSameUser ? 4 : 16);
        },
        itemCount: widget.controller.store.messages.length,
        itemBuilder: (context, index) {
          return Observer(
            builder: (context) {
              final message = widget.controller.store.messages[index];
              final previousMessage = index > 0 ? widget.controller.store.messages[index - 1] : null;
              final isMessageFromCurrentUser = widget.controller.store.isMessageFromCurrentUser(message);
              final isSameUser = previousMessage != null && message.userId == previousMessage.userId;

              final builder = widget.controller.viewFactory.buildFor(
                context,
                message: message,
                isMessageFromCurrentUser: isMessageFromCurrentUser,
              );
              final messageItem = builder ?? UnsupportMessageItem(isCurrentUser: isMessageFromCurrentUser);
              final user = widget.controller.store.users[message.userId];
              final userAvatar =
                  isSameUser ? SizedBox(width: context.layoutTheme.userAvatarSize) : UserAvatar(user: user);

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
