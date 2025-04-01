import 'package:simple_chat/models/base_message.dart';

/// The loading indicator message for the chat.
class ModelLoadingIndicatorMessage extends ModelBaseMessage {
  /// The id of the message.
  @override
  final String id;

  /// The user id of the message.
  @override
  final String userId;

  /// The sequence of the message.
  @override
  final int sequence;

  /// The display datetime of the message.
  @override
  final DateTime displayDatetime;

  /// The constructor of the loading indicator message.
  ModelLoadingIndicatorMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
  });
}
