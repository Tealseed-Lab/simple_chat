import 'package:image_picker/image_picker.dart';

class MessageSendOutput {
  final String message;
  final List<XFile> imageFiles;

  MessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
