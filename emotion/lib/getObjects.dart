import 'package:emotion/record.dart';

class ObjectCreater {
  static Record? record;

  static setRecord(Record record) {
    record = Record();
  }

  static Record getRecord() {
    return record!;
  }
}
