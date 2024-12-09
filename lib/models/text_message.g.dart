// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTextMessage _$ModelTextMessageFromJson(Map<String, dynamic> json) =>
    ModelTextMessage(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      sequence: (json['sequence'] as num).toInt(),
      displayDatetime: DateTime.parse(json['display_datetime'] as String),
      text: json['text'] as String,
    )..status = $enumDecode(_$ModelBaseMessageStatusEnumMap, json['status']);

Map<String, dynamic> _$ModelTextMessageToJson(ModelTextMessage instance) =>
    <String, dynamic>{
      'status': _$ModelBaseMessageStatusEnumMap[instance.status]!,
      'id': instance.id,
      'user_id': instance.userId,
      'sequence': instance.sequence,
      'display_datetime': instance.displayDatetime.toIso8601String(),
      'text': instance.text,
    };

const _$ModelBaseMessageStatusEnumMap = {
  ModelBaseMessageStatus.normal: 'normal',
  ModelBaseMessageStatus.failedToSend: 'failedToSend',
  ModelBaseMessageStatus.sending: 'sending',
  ModelBaseMessageStatus.sent: 'sent',
  ModelBaseMessageStatus.received: 'received',
  ModelBaseMessageStatus.read: 'read',
};
