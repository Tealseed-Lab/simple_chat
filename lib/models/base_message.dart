import 'package:flutter/material.dart';

enum ModelBaseMessageStatus {
  // developed
  normal,
  failedToSend,
  // wip
  sending,
  sent,
  received,
  read,
}

abstract class ModelBaseMessage {
  final widgetKey = GlobalKey();
  String get id;
  String get userId;
  int get sequence;
  DateTime get displayDatetime;
  bool get forceNewBlock => false;

  ModelBaseMessageStatus status = ModelBaseMessageStatus.normal;
}
