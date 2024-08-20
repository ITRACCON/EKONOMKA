import 'package:shophimikat/data/server/api.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';

class OrderRepository {
  final Api _appApi = Api();
// Получение данных о пользователе
  Future<bool> placinOrder(
      int userId,
      List<BasketProduct> basketProducts,
      String fio,
      String date,
      String gender,
      String phone,
      String email,
      String adress,
      String tg,
      int skidkaBonus,
      int skidkaPromocode,
      String promocode,
      String base64Image,
      String fileName) async {
    bool res = await _appApi.placingOrder(
        userId,
        basketProducts,
        fio,
        date,
        gender,
        phone,
        email,
        adress,
        tg,
        skidkaBonus,
        skidkaPromocode,
        promocode,
        base64Image,
        fileName);
    if (res) {
      if (tg.isEmpty) {
        UserModel user = await UserDao().getUser();
        UserModel newUser = UserModel(
            userId: user.userId,
            phone: phone,
            referalcode: user.referalcode,
            coin: user.coin - skidkaBonus,
            typeAcc: user.typeAcc,
            userTgId: user.userTgId,
            userTgFl: user.userTgFl,
            userTgName: user.userTgName,
            admin: user.admin);
        await UserDao().updateUser(newUser);
      }
    }
    return res;
  }
}
