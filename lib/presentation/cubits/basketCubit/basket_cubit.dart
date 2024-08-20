import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/repositories/basket_repository.dart';
import 'package:shophimikat/domain/models/basket_model.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

part 'basket_cubit.freezed.dart';

part 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepository _basketRepository = BasketRepository();
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  BasketCubit() : super(const Loading());

  Future<void> initialBasket() async {
    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    Map result =
        await _basketRepository.getBasket(user != null ? user.userId : 0);
    if (result['result']) {
      List<BasketProduct> basketProducts = List.of(result['basketProducts']);
      emit(Intial(basketProducts));
    } else {
      emit(const Error(''));
    }
  }

  Future<void> addProductBasket(int productId, int amount, String page) async {
    if (page == 'catalog') {
      emit(const Loading());
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != 0) {
        bool result = await _basketRepository.addProductBasket(
            user.userId, productId, amount);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    } else {
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.addProductBasket(
            user.userId!, productId, amount);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        } else {
          Map result = await _basketRepository
              .getBasket(user != null ? user.userId! : 0);
          if (result['result']) {
            List<BasketProduct> basketProducts =
                List.of(result['basketProducts']);
            emit(Intial(basketProducts));
          }
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    }
  }

  Future<void> addAmountBasketProduct(
      int productId, int amount, String page) async {
    if (page == 'catalog') {
      emit(const Loading());
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.addAmountBasketProduct(
            user.userId!, productId, amount);
        if (!result) {
          emit(Error('Ошибка при покупке товара'));
        }
      } else {
        emit(Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    } else {
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.addAmountBasketProduct(
            user.userId!, productId, amount);
        if (!result) {
          emit(Error('Ошибка при покупке товара'));
        } else {
          Map result = await _basketRepository
              .getBasket(user != null ? user.userId! : 0);
          if (result['result']) {
            List<BasketProduct> basketProducts =
                List.of(result['basketProducts']);
            emit(Intial(basketProducts));
          }
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    }
  }

  Future<void> minusAmountBasketProduct(
      int productId, int amount, String page) async {
    if (page == 'catalog') {
      emit(const Loading());
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.minusAmountBasketProduct(
            user.userId!, productId, amount);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    } else {
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.minusAmountBasketProduct(
            user.userId!, productId, amount);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        } else {
          Map result = await _basketRepository
              .getBasket(user != null ? user.userId! : 0);
          if (result['result']) {
            List<BasketProduct> basketProducts =
                List.of(result['basketProducts']);
            emit(Intial(basketProducts));
          }
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    }
  }

  Future<void> remuveProductBasket(int productId, String page) async {
    if (page == 'catalog') {
      emit(const Loading());
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.remuveProductBasket(
            user.userId!, productId);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    } else {
      final user = webAppInitData.hash == null
          ? await UserDao().getUser()
          : await UserTgProvider.getUser();
      if (user != null) {
        bool result = await _basketRepository.remuveProductBasket(
            user.userId!, productId);
        if (!result) {
          emit(const Error('Ошибка при покупке товара'));
        } else {
          Map result = await _basketRepository
              .getBasket(user != null ? user.userId! : 0);
          if (result['result']) {
            List<BasketProduct> basketProducts =
                List.of(result['basketProducts']);
            emit(Intial(basketProducts));
          }
        }
      } else {
        emit(const Error('Для покупки товара не обходимо пройти авторизацию'));
      }
    }
  }
}
