import 'package:easy_chat/easy_chat.dart';

class EasyChatActionHandler {
  final Future<void> Function(ModelBaseMessage message)? onSendMessage;
  EasyChatActionHandler({
    this.onSendMessage,
  });
}
