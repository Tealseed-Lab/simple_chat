import 'package:image_picker/image_picker.dart';
import 'package:tealseed_chat/models/base_message.dart';
import 'package:tealseed_chat/models/base_user.dart';
import 'package:tealseed_chat/models/message_send_output.dart';

class ChatActionHandler {
  final Future<void> Function(TealseedChatMessageSendOutput)? onSendMessage;
  final Future<void> Function(ModelBaseMessage)? onMessageTap;
  final Future<void> Function(XFile)? onImageThumbnailTap;
  final Future<void> Function(ModelBaseUser?)? onUserAvatarTap;
  ChatActionHandler({
    this.onSendMessage,
    this.onMessageTap,
    this.onImageThumbnailTap,
    this.onUserAvatarTap,
  });
}
