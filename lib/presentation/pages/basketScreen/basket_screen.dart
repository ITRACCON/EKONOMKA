import 'package:flutter/material.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/presentation/cubits/appBarCubit/appbar_cubit.dart';
import 'package:shophimikat/presentation/pages/basketScreen/widgets/basket_content.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class BasketScreen extends StatelessWidget {
  final List<BasketProduct> basket;
  final void Function(int productID, int amount) addAmountBasketProduct;
  final void Function(int productID, int amount) minusAmountBasketProduct;
  final void Function(int productID) remuveProductBasket;
  final AppBarCubit appBarCubit;
  const BasketScreen(
      {super.key,
      required this.basket,
      required this.addAmountBasketProduct,
      required this.minusAmountBasketProduct,
      required this.remuveProductBasket,
      required this.appBarCubit});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.basket,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: true,
        content: basket.isEmpty
            ? const BasketEmptyContent()
            : BasketContent(
                basket: basket,
                addAmountBasketProduct: (productID, amount) =>
                    addAmountBasketProduct(productID, amount),
                minusAmountBasketProduct: (productID, amount) =>
                    minusAmountBasketProduct(productID, amount),
                remuveProductBasket: (productID) =>
                    remuveProductBasket(productID),
              ));
  }
}
