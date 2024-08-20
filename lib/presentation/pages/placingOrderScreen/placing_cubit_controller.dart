import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/presentation/cubits/orderCubit/order_cubit.dart';
import 'package:shophimikat/presentation/pages/placingOrderScreen/placing_order_scree.dart';
import 'package:shophimikat/presentation/pages/placingOrderScreen/widgets/success_oreder.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/utils/constants/enums.dart';

class PlacingOrderCubitControllerScreenWeb extends StatefulWidget {
  final List<BasketProduct> basketProducts;
  const PlacingOrderCubitControllerScreenWeb(
      {super.key, required this.basketProducts});

  @override
  State<PlacingOrderCubitControllerScreenWeb> createState() =>
      _PlacingOrderCubitControllerScreenWebState();
}

class _PlacingOrderCubitControllerScreenWebState
    extends State<PlacingOrderCubitControllerScreenWeb> {
  late OrderCubit cubit;
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  @override
  void initState() {
    super.initState();
    cubit = OrderCubit()..init();
  }

  @override
  void dispose() {
    widget.basketProducts.clear();
    super.dispose();
  }

  placingOrder(
      List<BasketProduct> basketProducts,
      String fio,
      String date,
      Gender gender,
      String phone,
      String email,
      String adress,
      int skidkaBonus,
      int skidkaPromocode,
      String promocode,
      XFile? checkImage) {
    cubit.placingOrder(
        basketProducts,
        fio,
        date,
        gender,
        phone,
        email,
        adress,
        webAppInitData.hash == null ? '' : webAppInitData.user!.id.toString(),
        skidkaBonus,
        skidkaPromocode,
        promocode,
        checkImage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
            init: (InfoApp infoApp) => PlacingOrderScreen(
                basketProducts: widget.basketProducts,
                infoApp: infoApp,
                placingOrderr: (List<BasketProduct> basketProducts,
                    String fio,
                    String date,
                    Gender? gender,
                    String phone,
                    String email,
                    String adress,
                    int skidkaBonus,
                    int skidkaPromocode,
                    String promocode,
                    XFile? checkImage) {
                  placingOrder(
                      basketProducts,
                      fio,
                      date,
                      gender!,
                      phone,
                      email,
                      adress,
                      skidkaBonus,
                      skidkaPromocode,
                      promocode,
                      checkImage);
                }),
            placingOrderSuccess: () => SuccessOreder(),
            placingOrderLoading: () => LoadingScreen(
              title: 'Загружаю',
              text: '',
              routName: '/corder',
              backPage: true,
            ),
            placingOrderError: () => ErrorScreen(
              title: 'Error',
              text: '',
              routName: '/order',
              backPage: true,
            ),
          );
        });
  }
}
