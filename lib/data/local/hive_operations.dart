import 'package:hive/hive.dart';
import 'package:shophimikat/data/local/entity/user_hive.dart';

class HiveOperationsService {
  //
  final _favBox = Hive.box<UserHive>('user');

  Future<int> addToFavBox(UserHive data) async {
    return _favBox.add(data);
  }

  Future<int> deleteFromFavBox() async {
    return _favBox.clear();
  }

  Box<UserHive> get favBox => _favBox;

  List<UserHive> get fetchFromFavBox => _favBox.values.toList();
}
