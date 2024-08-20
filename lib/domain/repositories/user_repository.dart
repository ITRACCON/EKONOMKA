import 'package:shophimikat/data/server/api.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:shophimikat/domain/models/user_model.dart';

class UserRepository {
  final Api _appApi = Api();
  final WebAppInitData webAppInitData = tg.initDataUnsafe;

// Получение данных о пользователе
  Future<Map> getUserTg(int idTg) async {
    Map res = await _appApi.getUserTg(idTg);
    return res;
  }

  // Получение данных о пользователе
  Future<Map> getUserWeb() async {
    if (webAppInitData.hash != null) {
      Map res = await _appApi.getUserTg(webAppInitData.user!.id);
      UserModel user = res['user'];
      await UserTgProvider.updateUser(user);
    }
    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    Map res = {};
    if (user != null) {
      res = {'result': true, 'user': user};
    } else {
      res = {'result': false};
    }
    return res;
  }

  Future<Map> getInfoUser() async {
    Map result = {};
    if (webAppInitData.hash != null) {
      Map res = await _appApi.getUserTg(webAppInitData.user!.id);
      UserModel user = res['user'];
      await UserTgProvider.updateUser(user);
    }
    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    if (user != null) {
      result = await _appApi.getInfoLk(user.userId, user.referalcode);
    } else {
      result = {'result': false};
    }
    return result;
  }

  Future<Map> loginUser(String phone, String password) async {
    Map res = await _appApi.loginUser(phone, password);
    return res;
  }

  Future<void> logout() async {
    await UserDao().logout();
  }

  Future<Map> regUser(String phone, String password, String referalcode) async {
    Map res = await _appApi.regUser(phone, password, referalcode);
    return res;
  }

  Future<Map> updatePhone(String phone, int userId) async {
    Map res = await _appApi.updatePhone(phone, userId);
    return res;
  }

  Future<Map> updatePassword(String password, int userId) async {
    Map res = await _appApi.updatePassword(password, userId);
    return res;
  }
}
