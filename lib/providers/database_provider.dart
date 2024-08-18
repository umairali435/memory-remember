import 'package:flutter/material.dart';
import 'package:memory/data/database.dart';
import 'package:memory/models/memory_model.dart';

class DatabaseProvider extends ChangeNotifier {
  MemoryDatabase appDatabase = MemoryDatabase();
  MemoryModel memoryModel = MemoryModel();
  TextEditingController nameController = TextEditingController();
  DatabaseProvider() {
    getAllAges();
  }
  Future addMemoryToDatabase() async {
    MemoryModel allMemoryModel = MemoryModel()
      ..title = memoryModel.title
      ..description = memoryModel.description
      ..icon = memoryModel.icon
      ..date = memoryModel.date
      ..time = memoryModel.time;
    await appDatabase.addMemoryData(allMemoryModel).then((value) {
      memoryModel = MemoryModel();
    });
    nameController.clear();
    await getAllAges();
  }

  List<MemoryModel> allAges = [];
  Future getAllAges() async {
    List<MemoryModel> allAgesData = await appDatabase.allMemoryData();
    allAges = allAgesData;
    notifyListeners();
  }
}
