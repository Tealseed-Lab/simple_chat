import 'package:json_annotation/json_annotation.dart';
import 'package:simple_chat/models/base_message.dart';

part 'text_message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ModelTextMessage extends ModelBaseMessage {
  // base message
  @override
  final String id;

  @override
  final String userId;

  @override
  final int sequence;

  @override
  final DateTime displayDatetime;

  @override
  final bool forceNewBlock;

  // text message
  final String text;

  ModelTextMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.text,
    this.forceNewBlock = false,
  });

  // parsing

  factory ModelTextMessage.fromJson(Map<String, dynamic> json) => _$ModelTextMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ModelTextMessageToJson(this);
}
