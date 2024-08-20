import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/adminCubit/admin_cubit.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/dashboard.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late AdminCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = AdminCubit()..initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.admin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: BlocBuilder<AdminCubit, AdminState>(
            bloc: cubit,
            builder: (context, state) {
              return state.when(
                initialStats: (List<UserModel> users, List<OrderUser> orders) =>
                    Dashboard(users: users, orderUsers: orders),
                initial: () => Container(),
                loading: () => const LoadingScreen(
                  backPage: true,
                  routName: '',
                  title: 'Загрузка',
                  text: '',
                ),
                error: (String error) => const ErrorScreen(
                    backPage: true,
                    routName: '',
                    title: 'Ошибка загрузки данных',
                    text:
                        'Извините, возникла проблема при загрузке данных о сайте. Пожалуйста, повторите попытку.'),
                success: () {
                  return Container();
                },
                initialMassAdd: (Map<dynamic, dynamic> init) => Container(),
                initEditProduct: (Product product) => Container(),
              );
            }));
  }
}
