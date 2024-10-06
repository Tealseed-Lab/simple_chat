import 'package:easy_chat/models/message_send_output.dart';

class EasyChatActionHandler {
  final Future<void> Function(MessageSendOutput)? onSendMessage;
  EasyChatActionHandler({
    this.onSendMessage,
  });
}
