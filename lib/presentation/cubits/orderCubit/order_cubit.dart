import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/domain/repositories/infoapp_repository.dart';
import 'package:shophimikat/domain/repositories/order_repository.dart';
import 'package:shophimikat/domain/models/basket_model.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:shophimikat/utils/constants/enums.dart';

part 'order_cubit.freezed.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository = OrderRepository();
  final InfoAppRepository _infoAppRepository = InfoAppRepository();

  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  OrderCubit() : super(const Loading());

  Future<void> init() async {
    Map infoAppRes = await _infoAppRepository.getInfoApp();
    if (infoAppRes['result']) {
      emit(Initial(infoAppRes['infoApp']));
    }
  }

  Future<void> placingOrder(
      List<BasketProduct> basketProducts,
      String fio,
      String date,
      Gender gender,
      String phone,
      String email,
      String adress,
      String tg,
      int skidkaBonus,
      int skidkaPromocode,
      String promocode,
      XFile? checkImage) async {
    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();

    String base64Image = base64Encode(await checkImage!.readAsBytes());
    String fileName = checkImage.name;

    bool result = await _orderRepository.placinOrder(
        user.userId!,
        basketProducts,
        fio,
        date,
        gender == Gender.man ? "Мужской" : 'Женский',
        phone,
        email,
        adress,
        tg,
        skidkaBonus,
        skidkaPromocode,
        promocode,
        base64Image,
        fileName);
    print(result);
    if (result) {
      emit(const Success());
    } else {
      emit(const Error());
    }
  }
}
