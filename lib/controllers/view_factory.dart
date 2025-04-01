import 'package:flutter/material.dart';
import 'package:simple_chat/models/base_message.dart';

/// The type of the message view builder.
typedef MessageViewBuilder<T extends ModelBaseMessage> = Widget Function(
  BuildContext context, {
  required bool isMessageFromCurrentUser,
  required T message,
});

/// The view factory for the chat.
class ViewFactory {
  /// The registry for the message view builder.
  final Map<Type, MessageViewBuilder> _registry = {};

  /// The method for the register.
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
        throw ArgumentError(
            'Message type mismatch: expected ${T.toString()}, but got ${message.runtimeType}');
      }
    };
  }

  /// The method for the build.
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
