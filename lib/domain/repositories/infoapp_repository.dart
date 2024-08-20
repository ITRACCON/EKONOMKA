import 'package:shophimikat/data/server/api.dart';

class InfoAppRepository {
  final Api _appApi = Api();
// Получение данных о пользователе
  Future<Map> getInfoApp() async {
    Map res = await _appApi.getInfoApp();
    return res;
  }

  // Получение данных о пользователе
  Future<Map> editInfo(
      int percent,
      String details,
      String onebannerBase64Image,
      String onebannerFileName,
      String twobannerBase64Image,
      String twobannerFileName,
      bool oneBannerEmpty,
      bool twoBannerEmpty) async {
    Map res = await _appApi.editInfo(
        percent,
        details,
        onebannerBase64Image,
        onebannerFileName,
        twobannerBase64Image,
        twobannerFileName,
        oneBannerEmpty,
        twoBannerEmpty);
    return res;
  }
}
