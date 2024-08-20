import 'package:hive/hive.dart';
import 'package:shophimikat/data/local/entity/user_hive.dart';
import 'package:shophimikat/data/local/hive_hellper.dart';
import 'package:shophimikat/data/local/hive_operations.dart';
import 'package:shophimikat/data/local/locator.dart';
import 'package:shophimikat/domain/models/user_model.dart';

const TABLE_NAME = 'user';
final _hiveService = locator<HiveOperationsService>();

List<UserModel> getListUser(List data) {
  return List.generate(data.length, (id) => UserModel.fromJson(data[id]));
}

class UserDao {
  Future<void> createUserWeb(UserModel newUser) async {
    UserHive newUserHive = UserHive(
        newUser.userId,
        newUser.phone,
        newUser.referalcode,
        newUser.coin,
        newUser.typeAcc,
        newUser.userTgId,
        newUser.userTgFl,
        newUser.userTgName,
        newUser.admin);
    await _hiveService.addToFavBox(newUserHive);
  }

  Future<void> updateUser(UserModel newUser) async {
    try {
      await Hive.box(TABLE_NAME).putAt(0, newUser);
    } catch (e) {}
  }

  Future<bool> logout() async {
    await _hiveService.deleteFromFavBox();
    return true;
  }

  Future<bool> checkUser() async {
    if (!Hive.isBoxOpen('user')) {
      await HiveHelper.openBoxes();
    }
    try {
      var box = await Hive.box(TABLE_NAME);
      await HiveHelper.closesBoxex();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<dynamic> getUser() async {
    try {
      List<UserHive> box = _hiveService.fetchFromFavBox;

      if (box.isNotEmpty) {
        UserModel user = UserModel(
          userId: box[0].userId,
          phone: box[0].phone,
          referalcode: box[0].referalcode,
          coin: box[0].coin,
          typeAcc: box[0].typeAcc,
          userTgId: box[0].userTgId,
          userTgFl: box[0].userTgFl,
          userTgName: box[0].userTgName,
          admin: box[0].admin,
        );
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
