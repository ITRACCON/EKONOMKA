import 'dart:convert';
import 'dart:math';

import 'package:shophimikat/data/server/http_client.dart';
import 'package:shophimikat/domain/dao/basket_dao.dart';
import 'package:shophimikat/domain/dao/order_dao.dart';
import 'package:shophimikat/domain/dao/product_dao.dart';
import 'package:shophimikat/domain/dao/promocode_dao.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/data/cfg.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';

class Api {
  // Получение данных о пользователе (телеграмм)
  Future<Map<String, dynamic>> getUserTg(int idTg) async {
    try {
      Map request = await AppHttpClient.post(
          AppConfing.userApi, {'action': 'GET_TG_USER', 'userID': idTg});

      if (request['result']) {
        Map body = request['body'];
        UserModel user = UserModel.fromJson(body);
        return {'result': true, 'user': user};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Авторизация пользователя
  Future<Map<String, dynamic>> loginUser(String phone, String password) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.userApi,
          {'action': 'LOGIN_USER', 'phone': phone, 'password': password});

      if (request['result']) {
        Map body = request['body'];
        if (body['resultLogin'] == 'SUCCESS') {
          UserModel user = UserModel.fromJson(body['user']);
          print(user);
          return {'result': true, 'user': user, 'resultLogin': 'SUCCESS'};
        } else if (body['resultLogin'] == 'FAIL_PASS') {
          return {'result': true, 'resultLogin': 'FAIL_PASS'};
        } else if (body['resultLogin'] == 'NO_USER') {
          return {'result': true, 'resultLogin': 'NO_USER'};
        }
        return {'result': false};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Регистрация пользоателей
  Future<Map<String, dynamic>> regUser(
      String phone, String password, String referalcode) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.userApi, {
        'action': 'REG_USER',
        'phone': phone,
        'password': password,
        'referal': referalcode
      });

      if (request['result']) {
        Map body = request['body'];
        if (body['resultLogin'] == 'SUCCESS') {
          UserModel user = UserModel.fromJson(body['user']);
          return {'result': true, 'user': user, 'resultLogin': 'SUCCESS'};
        } else if (body['resultLogin'] == 'PHONE_USE') {
          return {'result': true, 'resultLogin': 'PHONE_USE'};
        }
        return {'result': false};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Обновление номера телефона
  Future<Map<String, dynamic>> updatePhone(String phone, int userId) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.userApi,
          {'action': 'UPD_PHONE', 'phone': phone, 'userID': userId});

      if (request['result']) {
        return {'result': true};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Обновление пароля
  Future<Map<String, dynamic>> updatePassword(
      String password, int userId) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.userApi,
          {'action': 'UPD_PASSWORD', 'password': password, 'userID': userId});

      if (request['result']) {
        return {'result': true};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Получение списка продуктов
  Future<Map<String, dynamic>> getProducts(String category) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.productsApi,
          {'action': 'GET_ALL_PRODUCTS', 'category': category});

      if (request['result']) {
        Map body = request['body'];
        List data = body['list'];
        List<Product> products = getListProducts(data);
        print(products);
        return {'result': true, 'products': products};
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Получение списка продуктов по акиции
  Future<Map<String, dynamic>> getSaleProducts() async {
    try {
      Map request = await AppHttpClient.post(
          AppConfing.productsApi, {'action': 'GET_SALE_PRODUCTS'});

      if (request['result']) {
        Map body = request['body'];
        List data = body['list'];
        List<Product> products = getListProducts(data);
        print(products);
        return {'result': true, 'products': products};
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Получение списка товаров в корзине пользователя
  Future<Map<String, dynamic>> getBasket(int userId) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi,
          {'action': 'GET_USER_BASKET', 'userID': userId});

      if (request['result']) {
        Map body = request['body'];
        List data = body['list'];
        List<BasketProduct> basketProducts = getListBasketProducts(data);
        return {'result': true, 'basketProducts': basketProducts};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Проверка есть ли товар в корзине
  Future<Map<String, dynamic>> getProductBasket(
      int userId, String productId) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi, {
        'action': 'GET_PRODUCT_BASKET',
        'userID': userId,
        'productID': productId
      });

      if (request['result']) {
        Map body = request['body'];
        List data = body['list'];
        if (data.isEmpty) {
          BasketProduct basketProduct = BasketProduct(amount: 0);
          return {'result': true, 'basketProduct': basketProduct};
        } else {
          BasketProduct basketProduct = BasketProduct.fromJson(data[0]);
          return {'result': true, 'basketProduct': basketProduct};
        }
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Добавление товара в корзину
  Future<Map<String, dynamic>> addProductBasket(
      int userId, int productID, int amount) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi, {
        'action': 'ADD_PRODUCT_BASKET',
        'userID': userId,
        'productID': productID,
        'amount': amount
      });
      print(request);
      if (request['result']) {
        return {
          'result': true,
        };
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Добавление кол товара в корзине
  Future<Map<String, dynamic>> addAmountBasketProduct(
      int userId, int productID, int amount) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi, {
        'action': 'ADD_BASKET_PRODUCT',
        'userID': userId,
        'productID': productID,
        'amount': amount
      });

      if (request['result']) {
        return {
          'result': true,
        };
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Уменьшение кол товара в корзине
  Future<Map<String, dynamic>> minusAmountBasketProduct(
      int userId, int productID, int amount) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi, {
        'action': 'MINUS_BASKET_PRODUCT',
        'userID': userId,
        'productID': productID,
        'amount': amount
      });

      if (request['result']) {
        return {
          'result': true,
        };
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Удаление товара из корзины
  Future<Map<String, dynamic>> remuveProductBasket(
      int userId, int productID) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi, {
        'action': 'REMOVE_PRODUCT_BASKET',
        'userID': userId,
        'productID': productID
      });

      if (request['result']) {
        return {
          'result': true,
        };
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

// Проверка на путсую корзину
  Future<Map<String, dynamic>> basketIsEmpty(int userId) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.basketApi,
          {'action': 'CHECK_BASKET_USER', 'userID': userId});

      if (request['result']) {
        Map body = request['body'];
        bool basketIsEmpt = body['isEmpty'];
        return {'result': true, 'basketIsEmpty': basketIsEmpt};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

// Оформление заказа
  Future<bool> placingOrder(
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
    String listTovar = '';
    int payMoney = 0;
    List photos = [];
    try {
      // Генерируем код заказа
      String orderId = generateRandomString(9);

      // Создаем текстовый список товаров для сообщения  о заказе
      basketProducts.forEach((basket) {
        listTovar += '''
🆔 <b>Артикул:</b> ${basket.product!.article}
🏷 <b>Название:</b> ${basket.product!.title}
🗃 <b>Колличество:</b> ${basket.amount}
💵 <b>Стоимость:</b> ${(basket.product!.sale == 0 ? basket.product!.price * basket.amount : basket.product!.salePrice * basket.amount).round()} ₽ 

''';
        payMoney += ((basket.product!.sale == 0
                    ? basket.product!.price
                    : basket.product!.salePrice) *
                basket.amount)
            .round();
      });

// Готовим описание и картинки для сообщения о заказе
      basketProducts.forEach((basket) => photos.add({
            'media': basket.product!.photo.toString(),
            'type': 'photo',
            'caption': '''
🆔 <b>Артикул:</b> ${basket.product!.article}
🏷 <b>Название:</b> ${basket.product!.title}
🗃 <b>Колличество:</b> ${basket.amount}
💵 <b>Стоимость:</b> ${(basket.product!.sale == 0 ? basket.product!.price * basket.amount : basket.product!.salePrice * basket.amount).round()} ₽ 

''',
            "parse_mode": "HTML",
          }));

      List prodList = [];

      basketProducts.forEach((basket) => prodList.add(basket.toDatabaseJson()));

// Делаем запрос на сервер о добавлении заказа
      Map request = await AppHttpClient.post(AppConfing.orderApi, {
        'action': 'ADD_ORDER',
        'userID': userId,
        'orderID': orderId,
        'products': json.encode(prodList),
        'fio': fio,
        'date': date,
        'gender': gender,
        'phone': phone,
        'email': email,
        'adress': adress,
        'tg': tg.isEmpty ? 'Сайт' : 'Телеграмм',
        'skidkaBonus': skidkaBonus,
        'skidkaPromocode': skidkaPromocode,
        'promocode': promocode,
        'fileName': fileName,
        'base64Image': base64Image,
        'sumaOrder': payMoney
      });

      if (request['result']) {
        await AppHttpClient.apiTg(AppConfing.sendMediaGroup, {
          'chat_id': AppConfing.idAdmin.toString(),
          'media': json.encode(photos),
          "parse_mode": "HTML",
        });

        await AppHttpClient.apiTg(AppConfing.sendPhoto, {
          'chat_id': AppConfing.idAdmin.toString(),
          'photo': '${AppConfing.serverAddress}/images/cheks/$fileName',
          'caption': '<b>Чек для заказа № Заказа:</b> #$orderId ',
          "parse_mode": "HTML",
        });

        Map reqTgSendMessage =
            await AppHttpClient.apiTg(AppConfing.sendMessage, {
          'chat_id': AppConfing.idAdmin.toString(),
          'text': '''
📦 <b>Новый заказ! № Заказа:</b> #$orderId 
🛒 <b>Товары:</b>

$listTovar

👤 Информация о покупателе: 
👨‍💼 <b>ФИО:</b> $fio
🗓 <b>Дата рождения:</b> $date
⚥ <b>Пол:</b> $gender
☎️ <b>Телефон:</b> <code>$phone</code>
📧 <b>Email:</b> <code>$email</code>
📍 <b>Адрес:</b> <code>$adress</code>
📄 <b>Заказ через:</b> ${tg.isEmpty ? 'Сайт' : 'Телеграмм'}

💳 <b>Сумма заказа:</b> $payMoney ₽ 
${skidkaBonus != 0 ? '💳 <b>Списано баллов:</b> - $skidkaBonus ₽' : ''}
${skidkaPromocode != 0 ? '💳 <b>Применение промокода ($promocode):</b> - $skidkaPromocode ₽' : ''}
💳 <b>Итого:</b> ${payMoney - skidkaBonus - skidkaPromocode} ₽ 

#новыйзаказ #продажи
''',
          "parse_mode": "HTML",
        });

        if (reqTgSendMessage['result']) {
          Map reqTgClearBasket = await AppHttpClient.post(AppConfing.basketApi,
              {'action': 'CLEAR_BASKET', 'userID': userId});

          if (reqTgClearBasket['result']) {
            if (tg.isNotEmpty) {
              Map reqTgSendMessageUser =
                  await AppHttpClient.apiTg(AppConfing.sendMessage, {
                'chat_id': '$tg',
                'text': '''
🎉 Поздравляем! Ваш заказ был успешно оформлен. 
<b>№ Заказа:</b> #$orderId 

🛒 <b>Товары:</b>
$listTovar

💳 <b>Итого:</b> $payMoney ₽

Ожидайте когда с вами свяжутся. Спасибо, что выбрали нас! 🚚🛍️
''',
                "parse_mode": "HTML"
              });

              if (reqTgSendMessageUser['result']) {
                return true;
              } else {
                return false;
              }
            } else {
              return true;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Проверка промокода
  Future<Map<String, dynamic>> checkPromocode(String promocode) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.promocodeApi,
          {'action': 'CHECK_PROMOCODE', 'promocode': promocode});

      if (request['result']) {
        Map body = request['body'];

        return {'result': body['result'], 'skidka': body['skidka']};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

  // Получение информации о пользователе
  Future<Map<String, dynamic>> getInfoLk(int userID, String referalcode) async {
    try {
      Map requestOrders = await AppHttpClient.post(
          AppConfing.orderApi, {'action': 'GET_ORDERS', 'userID': userID});

      if (requestOrders['result']) {
        Map body = requestOrders['body'];

        List ordersData = body['list'];
        List<OrderUser> orders = getListUserOrders(ordersData);

        Map requestCounRefs = await AppHttpClient.post(AppConfing.userApi,
            {'action': 'COUNT_REFS', 'referalCode': referalcode});

        if (requestCounRefs['result']) {
          Map body = requestCounRefs['body'];
          int countRefs = int.parse(body['countRefs']);
          return {'result': true, 'countRefs': countRefs, 'orders': orders};
        } else {
          return {'result': false};
        }
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

// Получениае статистики и информации о проекте
  Future<Map<String, dynamic>> getStats() async {
    try {
      Map requestOrders = await AppHttpClient.post(
          AppConfing.adminApi, {'action': 'GET_STATS'});

      if (requestOrders['result']) {
        Map body = requestOrders['body'];
        List usersData = body['users']['list'];

        List<UserModel> users = getListUser(usersData);
        List ordersData = body['orders']['list'];

        List<OrderUser> orders = getListUserOrders(ordersData);

        return {'result': true, 'users': users, 'orders': orders};
      } else {
        return {'result': false};
      }
    } catch (e) {
      return {'result': false};
    }
  }

// Редактипрованеи товара
  Future<bool> addProduct(String article, String title, String price,
      String base64Image, String fileName, String categorie) async {
    print('API');
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'ADD_PRODUCT',
        'article': article,
        'title': title,
        'price': price,
        'categorie': categorie,
        'fileName': fileName,
        'base64Image': base64Image,
      });

      if (requestOrders['result']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Редактипрованеи товара
  Future<bool> editProduct(
      String article,
      String title,
      String price,
      String categorie,
      String base64Image,
      String fileName,
      bool isImageEmpty,
      int salePrice,
      int sale) async {
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'EDIT_PRODUCT',
        'article': article,
        'title': title,
        'price': price,
        'categorie': categorie,
        'base64Image': base64Image,
        'fileName': fileName,
        'isImageEmpty': isImageEmpty,
        'salePrice': salePrice,
        'sale': sale
      });

      if (requestOrders['result']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Удаление продукта
  Future<bool> deleteProduct(int article) async {
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'DELETE_PRODUCT',
        'article': article,
      });

      if (requestOrders['result']) {
        Map body = requestOrders['body'];
        if (body['result'] == 'delete') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Получение списка продуктов
  Future<Map<String, dynamic>> getPromocodes() async {
    try {
      Map request = await AppHttpClient.post(
          AppConfing.promocodeApi, {'action': 'GET_ALL_PROMOCODES'});

      if (request['result']) {
        Map body = request['body'];
        List data = body['list'];
        List<PromocodeModel> promocodes = getListPromocodes(data);
        return {'result': true, 'promocodes': promocodes};
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Редактипрованеи товара
  Future<bool> addPromocode(String promocode, int skidka) async {
    print('API');
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'ADD_PROMOCODE',
        'promocode': promocode,
        'skidka': skidka
      });

      if (requestOrders['result']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Редактипрованеи товара
  Future<bool> editPromocode(int id, String promocode, int skidka) async {
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'EDIT_PROMOCODE',
        'idPromocode': id,
        'promocode': promocode,
        'skidka': skidka
      });

      if (requestOrders['result']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Удаление промкода
  Future<bool> deletePromocode(int id) async {
    try {
      Map requestOrders = await AppHttpClient.post(AppConfing.adminApi, {
        'action': 'DELETE_PROMOCODE',
        'idPromocode': id,
      });

      if (requestOrders['result']) {
        Map body = requestOrders['body'];
        if (body['result'] == 'delete') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Получение списка продуктов
  Future<Map<String, dynamic>> getInfoApp() async {
    try {
      Map request = await AppHttpClient.post(
          AppConfing.infoAppApi, {'action': 'GET_INFO'});

      if (request['result']) {
        Map body = request['body'];

        InfoApp infoApp = InfoApp.fromJson(body);
        return {'result': true, 'infoApp': infoApp};
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }

  // Получение списка продуктов
  Future<Map<String, dynamic>> editInfo(
      int percent,
      String details,
      String onebannerBase64Image,
      String onebannerFileName,
      String twobannerBase64Image,
      String twobannerFileName,
      bool oneBannerEmpty,
      bool twoBannerEmpty) async {
    try {
      Map request = await AppHttpClient.post(AppConfing.infoAppApi, {
        'action': 'EDIT_INFO',
        'percent': percent,
        'details': details,
        'onebannerBase64Image': onebannerBase64Image,
        'onebannerFileName': onebannerFileName,
        'twobannerBase64Image': twobannerBase64Image,
        'twobannerFileName': twobannerFileName,
        'oneBannerEmpty': oneBannerEmpty,
        'twoBannerEmpty': twoBannerEmpty
      });

      if (request['result']) {
        Map body = request['body'];

        return {'result': true};
      } else {
        return {'result': false};
      }
    } catch (e) {
      print(e);
      return {'result': false};
    }
  }
}

String generateRandomString(int len) {
  var r = Random();
  const chars = '1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
