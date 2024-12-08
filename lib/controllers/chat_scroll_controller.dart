import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

  double _previousBottomInset = 0;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    // Only jump to bottom when keyboard is shown (bottomInset increases)
    if (bottomInset > _previousBottomInset) {
      jumpToBottom();
    }
    _previousBottomInset = bottomInset;
  }

  // public

  bool isAtTop() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels <= 1;
  }

  bool isAtBottom() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels >= position.maxScrollExtent - 1 || position.viewportDimension >= position.maxScrollExtent;
  }

  Future<void> scrollToTop() async {
    if (controller.hasClients) {
      if (controller.offset > 0) {
        await controller.animateTo(
          0,
          duration: Duration(milliseconds: animationDurationInMilliseconds),
          curve: Curves.easeOut,
        );
      }
    }
  }

  Future<void> scrollToBottom() async {
    if (controller.hasClients) {
      Logger().i(
          '[easy-chat-scroll-controller] scrollToBottom check offset: ${controller.offset}, maxScrollExtent: ${controller.position.maxScrollExtent}');
      while (controller.offset + 1 < controller.position.maxScrollExtent) {
        Logger().i(
            '[easy-chat-scroll-controller] scrollToBottom offset: ${controller.offset}, maxScrollExtent: ${controller.position.maxScrollExtent}');
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(milliseconds: animationDurationInMilliseconds),
          curve: Curves.easeOut,
        );
        await Future.delayed(
          Duration(milliseconds: animationDurationInMilliseconds),
        );
      }
    }
  }

  Future<void> jumpToTop() async {
    if (controller.hasClients) {
      if (controller.offset > 0) {
        controller.jumpTo(0);
      }
    }
  }

  Future<void> jumpToBottom() async {
    if (controller.hasClients) {
      while (controller.offset + 1 < controller.position.maxScrollExtent) {
        Logger().i(
            '[easy-chat-scroll-controller] jumpToBottom offset: ${controller.offset}, maxScrollExtent: ${controller.position.maxScrollExtent}');
        controller.jumpTo(
          controller.position.maxScrollExtent,
        );
        await Future.delayed(
          Duration(milliseconds: animationDurationInMilliseconds),
        );
      }
    }
  }

  double getOffset() {
    return controller.offset;
  }

  void setOffset(double offset) {
    controller.jumpTo(offset);
  }

  // private
}
