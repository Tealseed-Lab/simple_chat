import 'package:simple_chat/models/base_message.dart';

class ModelLoadingIndicatorMessage extends ModelBaseMessage {
  @override
  final String id;

  @override
  final String userId;

  @override
  final int sequence;

  @override
  final DateTime displayDatetime;

  ModelLoadingIndicatorMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
  });
}
