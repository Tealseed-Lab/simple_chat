import 'package:easy_chat/models/message_send_output.dart';

class EasyChatActionHandler {
  final Future<void> Function(EasyMessageSendOutput)? onSendMessage;
  EasyChatActionHandler({
    this.onSendMessage,
  });
}
