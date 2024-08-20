import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/presentation/cubits/appBarCubit/appbar_cubit.dart';
import 'package:shophimikat/presentation/cubits/basketCubit/basket_cubit.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

import 'basket_screen.dart';

class BasketCubitControllerScreen extends StatefulWidget {
  const BasketCubitControllerScreen({super.key});

  @override
  State<BasketCubitControllerScreen> createState() =>
      _BasketCubitControllerScreenState();
}

class _BasketCubitControllerScreenState
    extends State<BasketCubitControllerScreen> {
  late BasketCubit cubit;
  late AppBarCubit appBarCubit;

  @override
  void initState() {
    super.initState();
    cubit = BasketCubit()..initialBasket();
    appBarCubit = AppBarCubit()..initialAppBar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addAmountBasketProduct(int productID, int amount) {
    cubit.addAmountBasketProduct(productID, amount, 'basket');
    cubit.initialBasket();
  }

  void minusAmountBasketProduct(int productID, int amount) {
    cubit.minusAmountBasketProduct(productID, amount, 'basket');
    cubit.initialBasket();
  }

  void remuveProductBasket(int productID) {
    cubit.remuveProductBasket(productID, 'basket');
    cubit.initialBasket();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
              initial: (List<BasketProduct> basketProducts) => BasketScreen(
                    appBarCubit: appBarCubit,
                    basket: basketProducts,
                    addAmountBasketProduct: (productID, amount) =>
                        addAmountBasketProduct(productID, amount),
                    minusAmountBasketProduct: (productID, amount) =>
                        minusAmountBasketProduct(productID, amount),
                    remuveProductBasket: (productID) =>
                        remuveProductBasket(productID),
                  ),
              loading: () => const LoadingScreen(
                    title: 'Загружаю',
                    text: '',
                    routName: AppRoutes.basket,
                    backPage: false,
                  ),
              error: (text) => const ErrorScreen(
                    title: 'Ошибка',
                    text: '',
                    routName: AppRoutes.basket,
                    backPage: false,
                  ),
              success: () => Container());
        });
  }
}
