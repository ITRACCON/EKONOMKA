import 'package:hive/hive.dart';
import 'package:shophimikat/data/local/entity/user_hive.dart';

class HiveHelper {
  HiveHelper._();

  static void registerAdapters() {
    Hive.registerAdapter<UserHive>(UserHiveAdapter());
  }

  static Future<void> openBoxes() async {
    await Hive.openBox<UserHive>('user');
  }

  static Future<void> closesBoxex() async {
    await Hive.box('user').close();
  }
}
