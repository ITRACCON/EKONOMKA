import 'dart:convert';

import 'package:shophimikat/domain/dao/basket_dao.dart';
import 'package:shophimikat/domain/models/basket_model.dart';

class OrderUser {
  int userId;
  int orderId;
  String fio;
  String phone;
  String email;
  String adress;
  String promocode;
  int skidkaBonus;
  int skidkaPromocode;
  List<BasketProduct> order;

  OrderUser(
      {required this.userId,
      required this.orderId,
      required this.fio,
      required this.phone,
      required this.email,
      required this.adress,
      required this.promocode,
      required this.skidkaBonus,
      required this.skidkaPromocode,
      required this.order});

  factory OrderUser.fromJson(Map<dynamic, dynamic> json) {
    return OrderUser(
        userId: int.parse(json['userId']),
        orderId: int.parse(json['orderId']),
        fio: json['fio'],
        phone: json['phone'],
        email: json['email'],
        adress: json['adress'],
        promocode: json['promocode'],
        skidkaBonus: int.parse(json['skidkaBonus']),
        skidkaPromocode: int.parse(json['skidkaPromocode']),
        order: getListBasketProductsOrder(jsonDecode(json['products'])));
  }

  Map<String, dynamic> toDatabaseJson() =>
      {'userId': this.userId, 'orderId': this.orderId};
}
