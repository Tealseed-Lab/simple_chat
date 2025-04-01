import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// The scroll controller for the chat.
class ChatScrollController with WidgetsBindingObserver {
  /// The scroll controller for the chat.
  final controller = ScrollController();

  /// The animation duration in milliseconds.
  final int animationDurationInMilliseconds;

  /// The constructor of the chat scroll controller.
  ChatScrollController({
    this.animationDurationInMilliseconds = 150,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  /// The method for the dispose.
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  // WidgetsBindingObserver

  double _previousBottomInset = 0;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    // Only jump to bottom when keyboard is shown (bottomInset increases)
    if (bottomInset > _previousBottomInset) {
      jumpToBottom();
    }
    _previousBottomInset = bottomInset;
  }

  // public

  /// The method for the is at top.
  bool isAtTop() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels <= 1;
  }

  /// The method for the is at bottom.
  bool isAtBottom() {
    if (!controller.hasClients) return false;
    final position = controller.position;
    return position.pixels >= position.maxScrollExtent - 1 ||
        position.viewportDimension >= position.maxScrollExtent;
  }

  /// The method for the scroll to top.
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

  /// The method for the scroll to bottom.
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

  /// The method for the jump to top.
  Future<void> jumpToTop() async {
    if (controller.hasClients) {
      if (controller.offset > 0) {
        controller.jumpTo(0);
      }
    }
  }

  /// The method for the jump to bottom.
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

  /// The method for the get offset.
  double getOffset() {
    return controller.offset;
  }

  /// The method for the set offset.
  void setOffset(double offset) {
    controller.jumpTo(offset);
  }

  // private
}
