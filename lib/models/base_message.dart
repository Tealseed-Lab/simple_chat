import 'package:flutter/material.dart';

abstract class ModelBaseMessage {
  final widgetKey = GlobalKey();
  String get id;
  String get userId;
  int get sequence;
  DateTime get displayDatetime;
  bool get forceNewBlock => false;
}
