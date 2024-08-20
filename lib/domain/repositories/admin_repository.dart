import 'package:shophimikat/data/server/api.dart';

class AdminRepository {
  final Api _appApi = Api();
// Получение данных о пользователе
  Future<Map> getStats() async {
    Map res = await _appApi.getStats();
    return res;
  }

  Future<bool> deleteProduct(int article) async {
    bool res = await _appApi.deleteProduct(article);
    return res;
  }

  Future<bool> editProduct(
      String article,
      String title,
      String price,
      String category,
      String base64Image,
      String fileName,
      bool isImageEmpty,
      int salePrice,
      int sale) async {
    bool res = await _appApi.editProduct(article, title, price, category,
        base64Image, fileName, isImageEmpty, salePrice, sale);
    return res;
  }

  Future<bool> deletePromocode(int id) async {
    bool res = await _appApi.deletePromocode(id);
    return res;
  }

  Future<bool> editPromocode(int id, String promocode, int skidka) async {
    bool res = await _appApi.editPromocode(id, promocode, skidka);
    return res;
  }
}
