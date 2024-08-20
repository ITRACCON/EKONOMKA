import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/presentation/cubits/infoAppCubit/infoapp_cubit.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/presentation/pages/homescreen/home_screen.dart';
import 'package:shophimikat/utils/helpers/helper_functions.dart';

class HomeCubitControllerScreen extends StatefulWidget {
  const HomeCubitControllerScreen({super.key});

  @override
  State<HomeCubitControllerScreen> createState() =>
      _CatalogCubitControllerScreenStateWeb();
}

class _CatalogCubitControllerScreenStateWeb
    extends State<HomeCubitControllerScreen> {
  late InfoAppCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = InfoAppCubit()..initHome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoAppCubit, InfoAppState>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
              initial: (InfoApp infoApp) => HomeScreen(
                    infoApp: infoApp,
                    products: [],
                    infoUser: {},
                  ),
              success: () => Container(),
              loading: () => Container(),
              error: (String error) => Container(),
              initialhome: (Map home) => HomeScreen(
                    infoApp: home['infoApp'],
                    products: home['saleProducts'],
                    infoUser: home['infoUser'],
                  ));
        });
  }
}
