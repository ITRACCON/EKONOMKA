import 'package:shophimikat/data/server/api.dart';

class ProductsRepository {
  final Api _appApi = Api();
// Получение данных о пользователе
  Future<Map> getProducts(String category) async {
    Map res = await _appApi.getProducts(category);
    return res;
  }

  Future<Map> getSaleProducts() async {
    Map res = await _appApi.getSaleProducts();
    return res;
  }

  Future<bool> addProduct(String article, String title, String price,
      String base64Image, String fileName, String category) async {
    print('REP');
    bool res = await _appApi.addProduct(
        article, title, price, base64Image, fileName, category);
    return res;
  }
}
