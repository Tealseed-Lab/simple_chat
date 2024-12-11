import 'package:image_picker/image_picker.dart';

class ChatMessageSendOutput {
  final String message;
  final List<XFile> imageFiles;

  ChatMessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
