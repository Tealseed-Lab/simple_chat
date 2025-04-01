import 'package:mobx/mobx.dart';
import 'package:simple_chat/models/base_message.dart';

part 'sequential_map.g.dart';

/// The sequential message map.
class SequentialMessageMap = SequentialMessageMapBase
    with _$SequentialMessageMap;

/// The base class for the sequential message map.
abstract class SequentialMessageMapBase with Store {
  /// The map for the messages.
  final ObservableMap<String, ModelBaseMessage> _map =
      ObservableMap<String, ModelBaseMessage>.of({});

  /// The order for the messages.
  final ObservableList<String> _order = ObservableList<String>.of([]);

  /// The message status map for the messages.
  @readonly
  ObservableMap<String, ModelBaseMessageStatus> _messageStatusMap =
      ObservableMap<String, ModelBaseMessageStatus>.of({});

  /// The computed for the sequential values.
  @computed
  ObservableList<ModelBaseMessage> get sequentialValues =>
      ObservableList.of(_order.map((id) => _map[id]!));

  /// The computed for the sequential values reversed.
  @computed
  ObservableList<ModelBaseMessage> get sequentialValuesReversed =>
      ObservableList.of(_order.reversed.map((id) => _map[id]!));

  /// The action for the get by id.
  @action
  ModelBaseMessage? getById(String id) => _map[id]; // Access by ID

  /// The action for the get highest sequence.
  @action
  int getHighestSequence() {
    if (_order.isEmpty) return 0;
    return _map[_order.first]?.sequence ?? 0;
  }

  /// The action for the upsert.
  @action
  void upsert(ModelBaseMessage msg) {
    if (!_map.containsKey(msg.id)) {
      // For new messages, add to order list
      _order.add(msg.id);
    }
    _map[msg.id] = msg;
    _messageStatusMap[msg.id] = msg.status;
    // Always resort to maintain correct order
    // This handles both new insertions and updates
    _order.sort((a, b) {
      final seqA = _map[a]?.sequence ?? 0;
      final seqB = _map[b]?.sequence ?? 0;
      return seqB.compareTo(seqA); // Descending order (newer messages first)
    });
  }

  /// The action for the upsert all.
  @action
  void upsertAll(List<ModelBaseMessage> msgs) {
    // Skip if empty list
    if (msgs.isEmpty) return;

    // Update or add each message to the map
    for (final msg in msgs) {
      if (!_map.containsKey(msg.id)) {
        _order.add(msg.id);
      }
      _map[msg.id] = msg;
      _messageStatusMap[msg.id] = msg.status;
    }

    // Sort the entire _order list based on sequence numbers
    _order.sort((a, b) {
      final seqA = _map[a]?.sequence ?? 0;
      final seqB = _map[b]?.sequence ?? 0;
      return seqB.compareTo(seqA); // Descending order (newer messages first)
    });
  }

  /// The action for the remove.
  @action
  void remove(String id) {
    if (_map.containsKey(id)) {
      _map.remove(id); // Remove from the map
      _order.remove(id); // Remove from the sequential order
      _messageStatusMap.remove(id);
    }
  }

  /// The action for the clear all.
  @action
  void clearAll() {
    _map.clear();
    _order.clear();
    _messageStatusMap.clear();
  }
}
