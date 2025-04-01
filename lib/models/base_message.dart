import 'package:flutter/material.dart';

/// The status of the message.
enum ModelBaseMessageStatus {
  /// developed
  /// The status of the message for the normal.
  normal,

  /// The status of the message for the failed to send.
  failedToSend,

  /// wip
  /// The status of the message for the sending.
  sending,

  /// The status of the message for the sent.
  sent,

  /// The status of the message for the received.
  received,

  /// The status of the message for the read.
  read,
}

/// The base message for the chat.
abstract class ModelBaseMessage {
  /// The widget key for the message.
  final widgetKey = GlobalKey();

  /// The id of the message.
  String get id;

  /// The user id of the message.
  String get userId;

  /// The sequence of the message.
  int get sequence;

  /// The display datetime of the message.
  DateTime get displayDatetime;

  /// The force new block of the message.
  bool get forceNewBlock => false;

  /// The status of the message.
  ModelBaseMessageStatus status = ModelBaseMessageStatus.normal;
}
