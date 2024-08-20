import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/domain/repositories/basket_repository.dart';
import 'package:shophimikat/domain/repositories/infoapp_repository.dart';
import 'package:shophimikat/domain/repositories/products_repository.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:shophimikat/domain/repositories/user_repository.dart';

part 'infoapp_cubit.freezed.dart';

part 'infoapp_state.dart';

class InfoAppCubit extends Cubit<InfoAppState> {
  final InfoAppRepository _infoAppRepository = InfoAppRepository();

  final ProductsRepository _productsRepository = ProductsRepository();
  final BasketRepository _basketRepository = BasketRepository();
  final UserRepository _userRepository = UserRepository();

  final WebAppInitData webAppInitData = tg.initDataUnsafe;

  InfoAppCubit() : super(const Loading());

  Future<void> init() async {
    Map infoAppRes = await _infoAppRepository.getInfoApp();
    if (infoAppRes['result']) {
      emit(Intial(infoAppRes['infoApp']));
    } else {
      emit(const Error('Ошибка получение данных'));
    }
  }

  Future<void> initHome() async {
    Map result = await _productsRepository.getSaleProducts();

    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();

    Map resultBasket =
        await _basketRepository.getBasket(user == null ? 0 : user.userId!);
    Map infoAppRes = await _infoAppRepository.getInfoApp();
    Map resultlk = await _userRepository.getInfoUser();
    final user1 = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    if (result['result'] && resultBasket['result'] && infoAppRes['result']) {
      List<BasketProduct> basketProducts = resultBasket['basketProducts'];

      List<Product> products = result['products'];
      emit(IntialHome({
        'infoApp': infoAppRes['infoApp'],
        'saleProducts': products,
        'infoUser': resultlk['result']
            ? {'countRefs': resultlk['countRefs'], 'orders': resultlk['orders'], 'referalcode': user1.referalcode}
            : {'countRefs': -1, 'orders': -1}
      }));
    }
  }

  Future<void> editInfo(
      int percent, String details, XFile? onebanner, XFile? twobanner) async {
    Map infoAppRes = await _infoAppRepository.getInfoApp();
    InfoApp infoaApp = infoAppRes['infoApp'];
    String onebannerBase64Image =
        onebanner != null ? base64Encode(await onebanner!.readAsBytes()) : '';
    String onebannerFileName =
        onebanner != null ? onebanner.name : infoaApp.onebanner;
    String twobannerBase64Image =
        twobanner != null ? base64Encode(await twobanner!.readAsBytes()) : '';
    String twobannerFileName =
        twobanner != null ? twobanner.name : infoaApp.twobanner;

    Map editReq = await _infoAppRepository.editInfo(
        percent,
        details,
        onebannerBase64Image,
        onebannerFileName,
        twobannerBase64Image,
        twobannerFileName,
        onebanner == null,
        twobanner == null);
    if (editReq['result']) {
      emit(Success());
    } else {
      emit(const Error('Ошибка получение данных'));
    }
  }
}
