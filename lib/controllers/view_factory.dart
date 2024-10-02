import 'package:easy_chat/models/base_message.dart';
import 'package:flutter/material.dart';

typedef MessageViewBuilder<T extends ModelBaseMessage> = Widget Function(
  BuildContext context, {
  required bool isMessageFromCurrentUser,
  required T message,
});

class ViewFactory {
  final Map<Type, MessageViewBuilder> _registry = {};

  void register<T extends ModelBaseMessage>(MessageViewBuilder<T> builder) {
    _registry[T] = (
      BuildContext context, {
      required bool isMessageFromCurrentUser,
      required ModelBaseMessage message,
    }) {
      if (message is T) {
        return builder(
          context,
          isMessageFromCurrentUser: isMessageFromCurrentUser,
          message: message,
        );
      } else {
        throw ArgumentError('Message type mismatch: expected ${T.toString()}, but got ${message.runtimeType}');
      }
    };
  }

  Widget? buildFor(
    BuildContext context, {
    required ModelBaseMessage message,
    required bool isMessageFromCurrentUser,
  }) {
    return _registry[message.runtimeType]?.call(
      context,
      isMessageFromCurrentUser: isMessageFromCurrentUser,
      message: message,
    );
  }
}
