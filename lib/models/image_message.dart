import 'package:json_annotation/json_annotation.dart';
import 'package:simple_chat/models/base_message.dart';

part 'image_message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ModelImageMessage extends ModelBaseMessage {
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
  final List<String> imageUrls;

  ModelImageMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.imageUrls,
    this.forceNewBlock = false,
  });

  // parsing

  factory ModelImageMessage.fromJson(Map<String, dynamic> json) => _$ModelImageMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ModelImageMessageToJson(this);
}
