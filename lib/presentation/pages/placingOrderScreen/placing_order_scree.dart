import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/presentation/pages/placingOrderScreen/widgets/order_content.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/enums.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class PlacingOrderScreen extends StatelessWidget {
  final List<BasketProduct> basketProducts;
  final void Function(
      List<BasketProduct> basketProducts,
      String fio,
      String date,
      Gender? gender,
      String phone,
      String email,
      String adress,
      int skidkaBonus,
      int skidkaPromocode,
      String promocode,
      XFile? checkImage) placingOrderr;
  final InfoApp infoApp;
  const PlacingOrderScreen(
      {super.key,
      required this.basketProducts,
      required this.placingOrderr,
      required this.infoApp});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/order',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: true,
        resizeToAvoidBottomInset: true,
        content: LoaderOverlay(
            child: OrderContent(
                basketProducts: basketProducts,
                infoApp: infoApp,
                placingOrder: (List<BasketProduct> basketProducts,
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
                  context.loaderOverlay.show();
                  placingOrderr(
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
                })));
  }
}
