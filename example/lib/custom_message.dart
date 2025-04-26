import 'package:flutter/material.dart';
import 'package:simple_chat/models/base_message.dart';

class CustomMessage extends ModelBaseMessage {
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

  final String data;

  @override
  bool get showAvatarAndPaddings => false;

  @override
  EdgeInsets? get customContainerPadding => EdgeInsets.zero;

  CustomMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.forceNewBlock,
    required this.data,
  });
}
