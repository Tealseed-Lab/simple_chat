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
        padding: context.layoutTheme.chatViewPadding,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: widget.controller.store.messages.length,
        itemBuilder: (context, index) {
          return Observer(
            builder: (context) {
              final message = widget.controller.store.messages[index];
              final isMessageFromCurrentUser = widget.controller.store.isMessageFromCurrentUser(message);
              final builder = widget.controller.viewFactory.buildFor(
                context,
                message: message,
                isMessageFromCurrentUser: isMessageFromCurrentUser,
              );
              final messageItem = builder ?? UnsupportMessageItem(isCurrentUser: isMessageFromCurrentUser);
              final user = widget.controller.store.users[message.userId];
              final userAvatar = UserAvatar(user: user);
              if (isMessageFromCurrentUser) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    messageItem,
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
                    messageItem,
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
