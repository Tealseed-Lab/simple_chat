abstract class ModelBaseMessage {
  String get id;
  String get userId;
  int get sequence;
  DateTime get displayDatetime;
  bool get forceNewBlock => false;
}
