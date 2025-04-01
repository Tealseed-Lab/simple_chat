import 'package:json_annotation/json_annotation.dart';
import 'package:simple_chat/models/base_message.dart';

part 'text_message.g.dart';

/// The text message for the chat.
@JsonSerializable(fieldRename: FieldRename.snake)
class ModelTextMessage extends ModelBaseMessage {
  // base message
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

  /// The force new block of the message.
  @override
  final bool forceNewBlock;

  /// The text of the message.
  final String text;

  /// The constructor of the text message.
  ModelTextMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.text,
    this.forceNewBlock = false,
  });

  // parsing

  /// The factory method for the text message from the json.
  factory ModelTextMessage.fromJson(Map<String, dynamic> json) =>
      _$ModelTextMessageFromJson(json);

  /// The method for the to json.
  Map<String, dynamic> toJson() => _$ModelTextMessageToJson(this);
}
