import 'package:flutter/material.dart';

class ChatScrollController with WidgetsBindingObserver {
  final controller = ScrollController();
  final int animationDurationInMilliseconds;

  ChatScrollController({
    this.animationDurationInMilliseconds = 150,
  }) {
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

  bool isAtTop() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels <= 1;
  }

  void scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: animationDurationInMilliseconds),
        curve: Curves.easeOut,
      );
    }
  }

  void scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: Duration(milliseconds: animationDurationInMilliseconds),
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

  void jumpToTop() {
    if (controller.hasClients) {
      controller.jumpTo(0);
    }
  }

  // private
}
