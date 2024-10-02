import 'package:easy_chat/models/base_message.dart';
import 'package:flutter/material.dart';

typedef MessageViewBuilder<T extends ModelBaseMessage> = Widget Function(
  BuildContext context, {
  required bool isMessageFromCurrentUser,
  required T message,
});

class ViewFactory<T extends ModelBaseMessage> {
  final Map<Type, MessageViewBuilder<T>> _registry = {};

  void register(MessageViewBuilder<T> builder) {
    _registry[T] = builder;
  }

  Widget? buildFor(
    BuildContext context, {
    required T message,
    required bool isMessageFromCurrentUser,
  }) {
    final builder = _registry[T];
    return builder?.call(
      context,
      message: message,
      isMessageFromCurrentUser: isMessageFromCurrentUser,
    );
  }
}
