import 'package:easy_asset_picker/picker/models/asset_image.dart';

/// The output for the message send.
class ChatMessageSendOutput {
  /// The message.
  final String message;

  /// The image files.
  final List<AssetImageInfo> imageFiles;

  /// The constructor of the message send output.
  ChatMessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
