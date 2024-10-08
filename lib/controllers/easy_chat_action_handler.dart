import 'package:easy_chat/models/base_message.dart';
import 'package:easy_chat/models/base_user.dart';
import 'package:easy_chat/models/message_send_output.dart';
import 'package:image_picker/image_picker.dart';

class EasyChatActionHandler {
  final Future<void> Function(EasyMessageSendOutput)? onSendMessage;
  final Future<void> Function(ModelBaseMessage)? onMessageTap;
  final Future<void> Function(XFile)? onImageThumbnailTap;
  final Future<void> Function(ModelBaseUser?)? onUserAvatarTap;
  EasyChatActionHandler({
    this.onSendMessage,
    this.onMessageTap,
    this.onImageThumbnailTap,
    this.onUserAvatarTap,
  });
}
