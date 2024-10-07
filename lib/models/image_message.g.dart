// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelImageMessage _$ModelImageMessageFromJson(Map<String, dynamic> json) =>
    ModelImageMessage(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      sequence: (json['sequence'] as num).toInt(),
      displayDatetime: DateTime.parse(json['display_datetime'] as String),
      imageUrls: (json['image_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ModelImageMessageToJson(ModelImageMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'sequence': instance.sequence,
      'display_datetime': instance.displayDatetime.toIso8601String(),
      'image_urls': instance.imageUrls,
    };
