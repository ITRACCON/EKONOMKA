import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/presentation/cubits/promocodeCubit/promocode_cubit.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/promocodelist_screen.dart';

class CatalogPromocodesAdminCubitControllerScreen extends StatefulWidget {
  final String? category;
  const CatalogPromocodesAdminCubitControllerScreen({super.key, this.category});

  @override
  State<CatalogPromocodesAdminCubitControllerScreen> createState() =>
      _CatalogPromocodesAdminCubitControllerScreenState();
}

class _CatalogPromocodesAdminCubitControllerScreenState
    extends State<CatalogPromocodesAdminCubitControllerScreen> {
  late PromocodeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = PromocodeCubit()..initPromocodes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initPromocodes(int page, String typePage) {
    cubit.initListPromocodes(page, typePage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromocodeCubit, PromocodeState>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
            initPromocodes:
                (List<PromocodeModel> promocodes, int pages, String typePage) =>
                    ListPromocodeAdminScreen(
              typePage: typePage,
              pages: pages,
              initPromocodes: (int page, String typePage) =>
                  initPromocodes(page, typePage),
              promocodes: promocodes,
            ),
            loading: () => LoadingScreen(
              title: 'Загружаю',
              text: '',
              routName: '/catalog/${widget.category}',
              backPage: false,
            ),
            error: () => ErrorScreen(
              title: 'Error',
              text: '',
              routName: '/catalog/${widget.category}',
              backPage: false,
            ),
            init: () => Container(),
            success: (Map<dynamic, dynamic> result) => Container(),
          );
        });
  }
}
