import 'package:flutter/material.dart';

class ChatScrollController with WidgetsBindingObserver {
  final controller = ScrollController();

  ChatScrollController() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  // WidgetsBindingObserver

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    // when keyboard is shown, jump to bottom
    if (bottomInset > 0) {
      _jumpToBottom();
    }
  }

  // public

  // private
  void _scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _jumpToBottom() {
    if (controller.hasClients) {
      controller.jumpTo(
        controller.position.maxScrollExtent,
      );
    }
  }
}
