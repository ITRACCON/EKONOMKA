import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/repositories/basket_repository.dart';
import 'package:shophimikat/domain/repositories/products_repository.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

part 'products_cubit.freezed.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository _productsRepository = ProductsRepository();
  final BasketRepository _basketRepository = BasketRepository();
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  ProductsCubit() : super(const Loading());

  Future<void> initialProducts(String category) async {
    Map result = await _productsRepository.getProducts(category);

    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();

    Map resultBasket =
        await _basketRepository.getBasket(user == null ? 0 : user.userId!);
    if (result['result'] && resultBasket['result']) {
      List<BasketProduct> basketProducts = resultBasket['basketProducts'];

      List<Product> products = result['products'];
      List<Product> prodPage = products.take((30)).toList();
      List<Map> catalog = [];
      prodPage.forEach((product) {
        if (basketProducts.isNotEmpty) {
          bool add = false;
          basketProducts.forEach((basketProduct) {
            if (!add) {
              if (basketProduct.product!.article == product.article) {
                catalog.add({
                  'product': product,
                  'buy': true,
                  'basketProduct': basketProduct
                });
                add = true;
              }
            }
          });
          if (!add) {
            catalog.add({'product': product, 'buy': false});
          }
          add = false;
        } else {
          catalog.add({'product': product, 'buy': false});
        }
      });
      emit(Intial(catalog, (products.length / 30).round(), 'initPage'));
    } else {
      emit(const Error());
    }
  }

  Future<bool> initCatalog(int minPrice, int maxPrice, String category,
      String sortCatalog, int page, String typePage, String searchReq) async {
    Map result = await _productsRepository.getProducts(category);
    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();

    Map resultBasket =
        await _basketRepository.getBasket(user == null ? 0 : user.userId!);
    if (result['result'] && resultBasket['result']) {
      List<BasketProduct> basketProducts = resultBasket['basketProducts'];
      List<Product> products = result['products'];
      List<Product> newList = [];
      List<Product> endList = [];
      List<String> searchReqList = searchReq.split(' ');
      if (searchReq != 'NO') {
        newList.addAll(products.where((product) =>
            product.article == searchReq ||
            searchReqList.every((searchWord) => product.title
                .toLowerCase()
                .contains(searchWord.toLowerCase()))));
      } else {
        newList.addAll(products);
      }

      switch (sortCatalog) {
        case 'Новинки':
          newList.sort((a, b) => b.id.compareTo(a.id));
          break;
        case 'Сначала дешевле':
          newList.sort((min, max) => min.price.compareTo(max.price));
          break;
        case 'Сначала дороже':
          newList.sort((min, max) => max.price.compareTo(min.price));
          break;
      }
      endList = newList
          .where((product) =>
              product.price >= minPrice && product.price < maxPrice)
          .toList();
      if (page == 1) {
        List<Product> pageList = endList.take(page * 30).toList();

        List<Map> catalog = [];
        pageList.forEach((product) {
          if (basketProducts.isNotEmpty) {
            bool add = false;
            basketProducts.forEach((basketProduct) {
              if (!add) {
                if (basketProduct.product!.article == product.article) {
                  catalog.add({
                    'product': product,
                    'buy': true,
                    'basketProduct': basketProduct
                  });
                  add = true;
                }
              }
            });
            if (!add) {
              catalog.add({'product': product, 'buy': false});
            }
            add = false;
          } else {
            catalog.add({'product': product, 'buy': false});
          }
        });
        emit(Intial(catalog, (endList.length / 30).round(), typePage));
      } else {
        List<Product> pageList =
            endList.skip((page - 1) * 30).take(30).toList();

        List<Map> catalog = [];
        pageList.forEach((product) {
          if (basketProducts.isNotEmpty) {
            bool add = false;
            basketProducts.forEach((basketProduct) {
              if (!add) {
                if (basketProduct.product!.article == product.article) {
                  catalog.add({
                    'product': product,
                    'buy': true,
                    'basketProduct': basketProduct
                  });
                  add = true;
                }
              }
            });
            if (!add) {
              catalog.add({'product': product, 'buy': false});
            }
            add = false;
          } else {
            catalog.add({'product': product, 'buy': false});
          }
        });
        emit(Intial(catalog, (endList.length / 30).round(), typePage));
      }

      return true;
    } else {
      emit(const Error());
      return false;
    }
  }
}
