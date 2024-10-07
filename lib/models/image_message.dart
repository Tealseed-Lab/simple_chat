import 'package:easy_chat/models/base_message.dart';
import 'package:json_annotation/json_annotation.dart';

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

  // text message
  final List<String> imageUrls;

  ModelImageMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.imageUrls,
  });

  // parsing

  factory ModelImageMessage.fromJson(Map<String, dynamic> json) => _$ModelImageMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ModelImageMessageToJson(this);
}
