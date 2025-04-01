import 'package:mobx/mobx.dart';
import 'package:simple_chat/models/base_message.dart';

part 'sequential_map.g.dart';

class SequentialMessageMap = SequentialMessageMapBase
    with _$SequentialMessageMap;

abstract class SequentialMessageMapBase with Store {
  final ObservableMap<String, ModelBaseMessage> _map =
      ObservableMap<String, ModelBaseMessage>.of({});
  final ObservableList<String> _order = ObservableList<String>.of([]);

  @readonly
  ObservableMap<String, ModelBaseMessageStatus> _messageStatusMap =
      ObservableMap<String, ModelBaseMessageStatus>.of({});

  @computed
  ObservableList<ModelBaseMessage> get sequentialValues =>
      ObservableList.of(_order.map((id) => _map[id]!));

  @computed
  ObservableList<ModelBaseMessage> get sequentialValuesReversed =>
      ObservableList.of(_order.reversed.map((id) => _map[id]!));

  @action
  ModelBaseMessage? getById(String id) => _map[id]; // Access by ID

  @action
  int getHighestSequence() {
    if (_order.isEmpty) return 0;
    return _map[_order.first]?.sequence ?? 0;
  }

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

  @action
  void remove(String id) {
    if (_map.containsKey(id)) {
      _map.remove(id); // Remove from the map
      _order.remove(id); // Remove from the sequential order
      _messageStatusMap.remove(id);
    }
  }

  @action
  void clearAll() {
    _map.clear();
    _order.clear();
    _messageStatusMap.clear();
  }
}
