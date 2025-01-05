import 'package:easy_asset_picker/picker/models/asset_image.dart';

class ChatMessageSendOutput {
  final String message;
  final List<AssetImageInfo> imageFiles;

  ChatMessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
