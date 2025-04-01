import 'package:easy_asset_picker/picker/models/asset_image.dart';
import 'package:simple_chat/models/base_message.dart';
import 'package:simple_chat/models/base_user.dart';
import 'package:simple_chat/models/message_send_output.dart';

/// The handler for the chat actions.
class ChatActionHandler {
  /// The callback for sending a message.
  final Future<void> Function(ChatMessageSendOutput)? onSendMessage;

  /// The callback for tapping a message.
  final Future<void> Function(ModelBaseMessage)? onMessageTap;

  /// The callback for tapping an image thumbnail.
  final Future<void> Function(AssetImageInfo)? onImageThumbnailTap;

  /// The callback for tapping a user avatar.
  final Future<void> Function(ModelBaseUser?)? onUserAvatarTap;

  /// The callback for tapping a message failed status.
  final Future<void> Function(ModelBaseMessage)? onMessageFailedStatusTap;

  /// The constructor of [ChatActionHandler].
  ChatActionHandler({
    this.onSendMessage,
    this.onMessageTap,
    this.onImageThumbnailTap,
    this.onUserAvatarTap,
    this.onMessageFailedStatusTap,
  });
}
