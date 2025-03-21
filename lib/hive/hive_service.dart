import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = 'favorites';


   Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(boxName);
  }

  void addFavorite(int id) {
    var box = Hive.box<int>(boxName);
    box.put(id, id);  // Store ID as key-value pair
  }

 void removeFavorite(int id) {
    var box = Hive.box<int>(boxName);
    box.delete(id);
  }

 bool isFavorite(int id) {
    var box = Hive.box<int>(boxName);
    return box.containsKey(id);
  }

}
