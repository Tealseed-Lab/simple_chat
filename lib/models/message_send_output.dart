import 'package:image_picker/image_picker.dart';

class TealseedChatMessageSendOutput {
  final String message;
  final List<XFile> imageFiles;

  TealseedChatMessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
