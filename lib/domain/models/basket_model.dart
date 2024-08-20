import 'package:shophimikat/domain/models/product_model.dart';

class BasketProduct {
  int amount;
  Product? product;

  BasketProduct({required this.amount, this.product});

  factory BasketProduct.fromJson(Map<dynamic, dynamic> json) {
    return BasketProduct(
        amount: int.parse(json['amount'].toString()),
        product: Product.fromJson(json));
  }

  factory BasketProduct.fromJsonOrder(Map<dynamic, dynamic> json) {
    return BasketProduct(
        amount: int.parse(json['amount'].toString()),
        product: Product.fromJson(json['product']));
  }

  Map<String, dynamic> toDatabaseJson() =>
      {'amount': this.amount, 'product': this.product!.toDatabaseJson()};
}

