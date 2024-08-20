import 'package:shophimikat/domain/models/basket_model.dart';

List<BasketProduct> getListBasketProducts(List data) {
  return List.generate(data.length, (id) => BasketProduct.fromJson(data[id]));
}

List<BasketProduct> getListBasketProductsOrder(List data) {
  return List.generate(
      data.length, (id) => BasketProduct.fromJsonOrder(data[id]));
}
