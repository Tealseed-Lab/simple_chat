// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequential_map.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SequentialMessageMap on SequentialMessageMapBase, Store {
  Computed<ObservableList<ModelBaseMessage>>? _$sequentialValuesComputed;

  @override
  ObservableList<ModelBaseMessage> get sequentialValues =>
      (_$sequentialValuesComputed ??=
              Computed<ObservableList<ModelBaseMessage>>(
                  () => super.sequentialValues,
                  name: 'SequentialMessageMapBase.sequentialValues'))
          .value;
  Computed<ObservableList<ModelBaseMessage>>?
      _$sequentialValuesReversedComputed;

  @override
  ObservableList<ModelBaseMessage> get sequentialValuesReversed =>
      (_$sequentialValuesReversedComputed ??=
              Computed<ObservableList<ModelBaseMessage>>(
                  () => super.sequentialValuesReversed,
                  name: 'SequentialMessageMapBase.sequentialValuesReversed'))
          .value;

  late final _$_messageStatusMapAtom = Atom(
      name: 'SequentialMessageMapBase._messageStatusMap', context: context);

  ObservableMap<String, ModelBaseMessageStatus> get messageStatusMap {
    _$_messageStatusMapAtom.reportRead();
    return super._messageStatusMap;
  }

  @override
  ObservableMap<String, ModelBaseMessageStatus> get _messageStatusMap =>
      messageStatusMap;

  @override
  set _messageStatusMap(ObservableMap<String, ModelBaseMessageStatus> value) {
    _$_messageStatusMapAtom.reportWrite(value, super._messageStatusMap, () {
      super._messageStatusMap = value;
    });
  }

  late final _$SequentialMessageMapBaseActionController =
      ActionController(name: 'SequentialMessageMapBase', context: context);

  @override
  ModelBaseMessage? getById(String id) {
    final _$actionInfo = _$SequentialMessageMapBaseActionController.startAction(
        name: 'SequentialMessageMapBase.getById');
    try {
      return super.getById(id);
    } finally {
      _$SequentialMessageMapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getHighestSequence() {
    final _$actionInfo = _$SequentialMessageMapBaseActionController.startAction(
        name: 'SequentialMessageMapBase.getHighestSequence');
    try {
      return super.getHighestSequence();
    } finally {
      _$SequentialMessageMapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void upsert(ModelBaseMessage msg) {
    final _$actionInfo = _$SequentialMessageMapBaseActionController.startAction(
        name: 'SequentialMessageMapBase.upsert');
    try {
      return super.upsert(msg);
    } finally {
      _$SequentialMessageMapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void upsertAll(List<ModelBaseMessage> msgs) {
    final _$actionInfo = _$SequentialMessageMapBaseActionController.startAction(
        name: 'SequentialMessageMapBase.upsertAll');
    try {
      return super.upsertAll(msgs);
    } finally {
      _$SequentialMessageMapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(String id) {
    final _$actionInfo = _$SequentialMessageMapBaseActionController.startAction(
        name: 'SequentialMessageMapBase.remove');
    try {
      return super.remove(id);
    } finally {
      _$SequentialMessageMapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sequentialValues: ${sequentialValues},
sequentialValuesReversed: ${sequentialValuesReversed}
    ''';
  }
}
