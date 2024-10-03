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
      jumpToBottom();
    }
  }

  // public

  bool isAtBottom() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels >= position.maxScrollExtent - 1 || position.viewportDimension >= position.maxScrollExtent;
  }

  void scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    }
  }

  void jumpToBottom() {
    if (controller.hasClients) {
      controller.jumpTo(
        controller.position.maxScrollExtent,
      );
    }
  }

  // private
}
