# Simple Chat

A simple UI solution for quick integration of IM chat & AI bot chat.

Supports customised Message Cell, message grouping, image preview and more.

[<image src="https://i0.wp.com/tealseed.com/wp-content/uploads/2024/08/header.png?resize=2048%2C683&ssl=1" />](https://tealseed.com)

## Supported Platforms

- iOS
- Android

## Screenshots
| <img src="https://github.com/user-attachments/assets/8b581597-650f-4e01-b667-187e86d28ed4" width="300" /> | <img src="https://github.com/user-attachments/assets/829a92e1-83af-4fa7-b280-a81fa761a97f" width="300" /> 
|-------------------------|-------------------------|

## Basics

### Initialise Controller & View

`ChatActionHandler` is used to handle events like sending message, user avatar tapping, image preview thumbntail tapping, etc.
`ChatConfig` is optional, you can customise the input box hint text, image max count, etc.

```dart
final controller = ChatController(
    config: ChatConfig(
      inputBoxHintText: 'Type a message...',
    ),
    actionHandler: ChatActionHandler(
      onSendMessage: (output) {},
    ),
);

ChatView(
    controller: controller,
    theme: ChatThemeData(
        dark: coloredThemeData,
        light: coloredThemeData,
    ),
)
```

### Config Users

Users configured with `id`, `name`, `avatarUrl` and `isCurrentUser` flag.
- `id` is used to identify the user and later display messages under the corresponding user avatar.
- `name` is used to display in the chat UI.
- `avatarUrl` is used to display the user avatar.
- `isCurrentUser` is used to identify if the user is the current user.

```dart
await controller.store.addUsers(users: [
    ModelUser(
        id: '1',
        name: 'Lawrence',
        avatarUrl: 'https://example.com/avatar/1.png',
        isCurrentUser: true,
    ),
    ModelUser(
        id: '2',
        name: 'Ciel',
        avatarUrl: 'https://example.com/avatar/2.png',
        isCurrentUser: false,
    ),
]);
```

### Add messages

- `isInitial` is used to identify if the message is historial message and determine if the message is shown with animation or not.
- `userId` is used to identify the user who sent the message.
- `sequence` is used to determine the order of the message.
- `displayDatetime` is used to determine the display datetime of the message.

```dart
await controller.store.addMessage(
    isInitial: !withDelay,
    message: ModelTextMessage(
        id: '$i',
        text: 'Hello, how are you?',
        userId: '1',
        sequence: i,
        displayDatetime: DateTime.now(),
    ),
);
```

### Loading Indicator
#### Blocking and show loading indicator
| <img src="https://github.com/user-attachments/assets/988c1c04-7db6-4cbb-a910-61a295ea208d" width="300" /> |
|-------------------------|
```dart
final controller = ChatController(
    config: ChatConfig(
        loadingIndicatorType: LoadingIndicatorType.sendBtnLoading,
    ),
);
```

#### Non-blocking and show reply generator
| <img src="https://github.com/user-attachments/assets/6f0da2f7-da79-45c1-957a-798800236d24" width="300" /> |
|-------------------------|
```dart
await controller.store.showReplyGeneratingIndicator();
await Future.delayed(const Duration(seconds: 3));
await controller.store.hideReplyGeneratingIndicator();
```
### Unread indicator

#### Indicator with unread count
| <img src="https://github.com/user-attachments/assets/d0c810b8-4733-4f28-aa39-8f96740bd1d1" width="300" /> |
|-------------------------|
```dart
final controller = ChatController(
    config: ChatConfig(
        showUnreadCount: true,
    ),
    ...
);
```
#### Indicator without unread count
| <img src="https://github.com/user-attachments/assets/35949e4e-9efa-4a98-b21c-ac7f6133e64d" width="300" /> |
|-------------------------|
```dart
final controller = ChatController(
    config: ChatConfig(
        showUnreadCount: false,
    ),
    ...
);
```

### Message status
For each message we can also set status, like `sending`, `failed to send`.
| <img src="https://github.com/user-attachments/assets/166091f7-e2c4-4968-af94-c88bdf07b0e2" width="300" /> |
|-------------------------|
```dart
await controller.store.updateSendStatus(
    messageId: messageId,
    status: ModelBaseMessageStatus.sending,
);
await controller.store.updateSendStatus(
    messageId: messageId,
    status: ModelBaseMessageStatus.failedToSend,
);
```


## Customisation
### Add your custom tool bar
Add a tool bar sticked on the top of the input box and move together while keyboard shown/dismissed.

| <img src="https://github.com/user-attachments/assets/83063bc8-9428-4986-92fe-34cf6017534d" width="300" /> |
|-------------------------|

```dart
ChatView(
    toolbar: Container(
    // custom toolbar
    ),
),
```

### Add your custom message cell UI

#### Define your custom message model

Normally if one user send multiple messages without interruption, they will be grouped together in one message cell.
If you want to group them in different message cells, you can set `forceNewBlock` to `true`.

```dart
class CustomMessage extends ModelBaseMessage {
  @override
  final String id;

  @override
  final String userId;

  @override
  final int sequence;

  @override
  final DateTime displayDatetime;

  @override
  final bool forceNewBlock;

  final String data;

  CustomMessage({
    required this.id,
    required this.userId,
    required this.sequence,
    required this.displayDatetime,
    required this.forceNewBlock,
    required this.data,
  });
}

```

#### Define your custom message cell UI

You can use `MessageBubble` to wrap your custom message cell UI.

```dart

class CustomMessageCell extends StatelessWidget {
  final ModelLoadingIndicatorMessage message;
  final bool isMessageFromCurrentUser;
  CustomMessageCell({
    super.key,
    required this.message,
    required this.isMessageFromCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return MessageBubble(
      isCurrentUser: isMessageFromCurrentUser,
      padding: const EdgeInsets.all(12),
      ...
    );
  }
}

```

#### Register your custom message cell UI with custom message model

After registeration, whenever a message with the custom message model is added, the registered UI will be used to display the message.

```dart
controller.viewFactory.register<CustomMessage>(
    (BuildContext context, {
    required CustomMessage message,
    required bool isMessageFromCurrentUser,
}) =>
    CustomMessageCell(
        message: message,
        isMessageFromCurrentUser: isMessageFromCurrentUser,
    ),
);
```
#### message cell with customised padding, show/hide avatar

```dart
class CustomMessage extends ModelBaseMessage {
    ...
    @override
    // this is to indicate whether to show/hide avatar & avatar placehoding spacing
    bool get showAvatarAndPaddings => false;

    @override
    // this is to customise message view padding
    EdgeInsets? get customContainerPadding => EdgeInsets.zero;
}
```

The above example will give message view zero padding and hide user avatar for message cell rendering

| <img src="https://github.com/user-attachments/assets/c2164b29-36ab-4bda-9210-102f040c61ee" width="300" /> |
|-------------------------|

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Tealseed-Lab/simple_chat&type=Date)](https://star-history.com/#Tealseed-Lab/simple_chat&Date)

