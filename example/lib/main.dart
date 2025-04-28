import 'dart:math'; // Added import for Random

import 'package:example/custom_message.dart';
import 'package:example/custom_message_view.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/simple_chat.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late final ChatController controller;
  var sequence = 0;
  final userId1 = const Uuid().v4();
  final userId2 = const Uuid().v4();
  @override
  void initState() {
    super.initState();
    controller = ChatController(
      config: ChatConfig(
        loadingIndicatorType: LoadingIndicatorType.noBlocking,
        showUnreadCount: true,
        imageMaxCount: 1,
      ),
      actionHandler: ChatActionHandler(
        onSendMessage: _handleSendingMessage,
        // onSendMessage: _handleSendingMessageWithStatus,
      ),
    );
    controller.viewFactory.register<CustomMessage>(
      (
        BuildContext context, {
        required CustomMessage message,
        required bool isMessageFromCurrentUser,
      }) =>
          CustomMessageView(
        message: message,
        isMessageFromCurrentUser: isMessageFromCurrentUser,
      ),
    );
    setupTests();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleSendingMessage(ChatMessageSendOutput output) async {
    if (output.message.isNotEmpty) {
      await controller.store.addMessage(
        message: ModelTextMessage(
          id: const Uuid().v4(),
          text: output.message,
          userId: userId1,
          sequence: sequence++,
          displayDatetime: DateTime.now(),
        ),
      );
    }
    if (output.imageFiles.isNotEmpty) {
      // in reality, it's usually better to upload images to server first
      await controller.store.addMessage(
        message: ModelImageMessage(
          id: const Uuid().v4(),
          userId: userId1,
          sequence: sequence++,
          displayDatetime: DateTime.now(),
          imageUrls: output.imageFiles.map((e) => e.path).toList(),
        ),
      );
    }
    await controller.store.showReplyGeneratingIndicator();
    await Future.delayed(const Duration(seconds: 3));
    await controller.store.hideReplyGeneratingIndicator();
    await controller.store.addMessage(
      message: ModelTextMessage(
        id: const Uuid().v4(),
        userId: userId2,
        sequence: sequence++,
        displayDatetime: DateTime.now(),
        text: 'Example reply~',
      ),
    );
  }

  // ignore: unused_element
  Future<void> _handleSendingMessageWithStatus(
      ChatMessageSendOutput output) async {
    if (output.message.isNotEmpty) {
      final messageId = const Uuid().v4();
      await controller.store.addMessage(
        message: ModelTextMessage(
          id: messageId,
          text: output.message,
          userId: userId1,
          sequence: sequence++,
          displayDatetime: DateTime.now(),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      await controller.store.updateSendStatus(
        messageId: messageId,
        status: ModelBaseMessageStatus.sending,
      );
      await Future.delayed(const Duration(seconds: 1));
      await controller.store.updateSendStatus(
        messageId: messageId,
        status: ModelBaseMessageStatus.failedToSend,
      );
    }
  }

  Future<void> setupTests() async {
    await injectUsers();
  }

  Future<void> injectUsers() async {
    await controller.store.addUsers(users: [
      ModelUser(
        id: userId1,
        name: 'Lawrence',
        avatarUrl:
            'https://lh3.googleusercontent.com/ogw/AF2bZyj1OQs6QwRQMGfY0H5g_VOdijzbC7Ea3XE3Z8eDYTrOZQ=s64-c-mo',
        isCurrentUser: true,
      ),
      ModelUser(
        id: userId2,
        name: 'Ciel',
        avatarUrl:
            'https://media.karousell.com/media/photos/profiles/2018/01/09/imwithye_1515485479.jpg',
        isCurrentUser: false,
      ),
    ]);
  }

  Future<void> injectMessages({required bool withDelay}) async {
    final random = Random();
    final totalCount = withDelay ? 1 : 100;
    for (var i = 0; i < totalCount; i++) {
      if (withDelay) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      final userId = random.nextBool() ? userId1 : userId2;
      final textLength =
          random.nextInt(50) + 10; // Random length between 10 and 59
      await controller.store.addMessage(
        isInitial: !withDelay,
        message: ModelTextMessage(
          id: const Uuid().v4(),
          text: generateRandomText(textLength),
          userId: userId,
          sequence: sequence++,
          displayDatetime: DateTime.now(),
        ),
      );
    }
  }

  Future<void> injectCustomMessage() async {
    await controller.store.addMessage(
      message: CustomMessage(
        id: const Uuid().v4(),
        userId: userId1,
        sequence: sequence++,
        displayDatetime: DateTime.now(),
        forceNewBlock: true,
        data: 'this is a custom message',
      ),
    );
  }

  String generateRandomText(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789 ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    final coloredThemeData = ChatColorThemeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'scroll_top':
                  controller.chatScrollController.scrollToTop();
                  break;
                case 'scroll_bottom':
                  controller.chatScrollController.scrollToBottom();
                  break;
                case 'inject_messages':
                  injectMessages(withDelay: false);
                  break;
                case 'inject_messages_delay':
                  injectMessages(withDelay: true);
                  break;
                case 'clear_all':
                  controller.store.clearAll();
                  break;
                case 'inject_custom_message':
                  injectCustomMessage();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'scroll_top',
                child: ListTile(
                  leading: Icon(Icons.arrow_upward),
                  title: Text('Scroll to Top'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'scroll_bottom',
                child: ListTile(
                  leading: Icon(Icons.arrow_downward),
                  title: Text('Scroll to Bottom'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'inject_messages',
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Inject Messages'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'inject_messages_delay',
                child: ListTile(
                  leading: Icon(Icons.auto_awesome),
                  title: Text('Inject Messages with Delay'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'clear_all',
                child: ListTile(
                  leading: Icon(Icons.clear),
                  title: Text('Clear All'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'inject_custom_message',
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Inject Custom Message'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ChatView(
        controller: controller,
        theme: ChatThemeData(
          dark: coloredThemeData,
          light: coloredThemeData,
        ),
        toolbar: Container(
          color: Colors.white,
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CompositedTransformTarget(
                link: layerLink,
                child: ElevatedButton(
                  onPressed: () {
                    _showOverlay(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                  child: const Text("Filter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  void _showOverlay(BuildContext context) {
    if (overlayEntry == null) {
      const overlayHeight = 100.0;
      const overlayWidth = 120.0;
      final overlay = Overlay.of(context);

      overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
          left: 0,
          top: 0,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            link: layerLink,
            offset: const Offset(0, -overlayHeight - 4),
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: overlayWidth,
                height: overlayHeight,
                child: TapRegion(
                  consumeOutsideTaps: true,
                  onTapOutside: (event) => _hideOverlay(),
                  child: Container(
                    height: overlayHeight,
                    width: overlayWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
      overlay.insert(overlayEntry!);
    } else {
      _hideOverlay();
    }
  }

  void _hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
