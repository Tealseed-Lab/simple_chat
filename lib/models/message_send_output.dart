import 'package:image_picker/image_picker.dart';

class EasyMessageSendOutput {
  final String message;
  final List<XFile> imageFiles;

  EasyMessageSendOutput({
    required this.message,
    required this.imageFiles,
  });
}
