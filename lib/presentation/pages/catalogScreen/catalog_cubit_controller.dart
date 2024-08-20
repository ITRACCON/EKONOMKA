import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/presentation/cubits/appBarCubit/appbar_cubit.dart';
import 'package:shophimikat/presentation/cubits/productsCubit/products_cubit.dart';
import 'package:shophimikat/presentation/pages/catalogScreen/catalog_screen.dart';
import 'package:shophimikat/common/widgets/error_screen.dart';
import 'package:shophimikat/common/widgets/loading_screen.dart';
import 'package:shophimikat/utils/helpers/helper_functions.dart';

class CatalogCubitControllerScreen extends StatefulWidget {
  final String? category;
  const CatalogCubitControllerScreen({super.key, this.category});

  @override
  State<CatalogCubitControllerScreen> createState() =>
      _CatalogCubitControllerScreenStateWeb();
}

class _CatalogCubitControllerScreenStateWeb
    extends State<CatalogCubitControllerScreen> {
  late ProductsCubit cubit;
  late AppBarCubit appBarCubit;

  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit()..initialProducts(widget.category ?? '');
    appBarCubit = AppBarCubit()..initialAppBar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initCatalog(int minPrice, int maxPrice, String category, String sort,
      int page, String typePage, String searchReq) {
    cubit.initCatalog(
        minPrice, maxPrice, category, sort, page, typePage, searchReq);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
            initial: (List<Map> products, int pages, String typePage) =>
                CatalogScreen(
              appBarCubit: appBarCubit,
              categoryCode: widget.category!,
              typePage: typePage,
              pages: pages,
              initCatalog: (int minPrice, int maxPrice, String sort, int page,
                      String typePage, String searchReq) =>
                  initCatalog(minPrice, maxPrice, widget.category ?? '', sort,
                      page, typePage, searchReq),
              products: products,
              category: AppHelperFunctions.getCategoryTitle(widget.category!),
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
          );
        });
  }
}
