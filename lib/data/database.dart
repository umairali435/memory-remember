import 'package:isar/isar.dart';
import 'package:memory/models/memory_model.dart';
import 'package:path_provider/path_provider.dart';

class MemoryDatabase {
  late Future<Isar> db;
  MemoryDatabase() {
    db = openDB();
  }

  Future<Isar> openDB({String? directory}) async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MemoryModelSchema],
        inspector: true,
        directory: directory ?? dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future addMemoryData(MemoryModel allAgesModel) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.memoryModels.put(allAgesModel);
    });
  }

  Future<List<MemoryModel>> allMemoryData() async {
    final isar = await db;
    return isar.memoryModels.where().findAll();
  }
}
