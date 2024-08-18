import 'package:isar/isar.dart';

part 'memory_model.g.dart';

@collection
class MemoryModel {
  Id id = Isar.autoIncrement;
  String? title;
  String? description;
  int? icon;
  String? date;
  String? time;
}
