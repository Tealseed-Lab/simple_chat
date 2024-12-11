import 'package:image_picker/image_picker.dart';
import 'package:simple_chat/models/base_message.dart';
import 'package:simple_chat/models/base_user.dart';
import 'package:simple_chat/models/message_send_output.dart';

class ChatActionHandler {
  final Future<void> Function(ChatMessageSendOutput)? onSendMessage;
  final Future<void> Function(ModelBaseMessage)? onMessageTap;
  final Future<void> Function(XFile)? onImageThumbnailTap;
  final Future<void> Function(ModelBaseUser?)? onUserAvatarTap;
  final Future<void> Function(ModelBaseMessage)? onMessageFailedStatusTap;
  ChatActionHandler({
    this.onSendMessage,
    this.onMessageTap,
    this.onImageThumbnailTap,
    this.onUserAvatarTap,
    this.onMessageFailedStatusTap,
  });
}
