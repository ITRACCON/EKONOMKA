import 'package:flutter/material.dart';
import 'package:shophimikat/presentation/cubits/appBarCubit/appbar_cubit.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/catalog_products/widgets/catalog_content.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class CatalogProducsAdminScreen extends StatelessWidget {
  final AppBarCubit appBarCubit;
  final List<Map> products;
  final String category;
  final String categoryCode;
  final int pages;
  final void Function(int minPrice, int maxPrice, String valueSort, int page,
      String typePage, String searchReq, String category) initCatalog;
  final String typePage;
  const CatalogProducsAdminScreen(
      {super.key,
      required this.category,
      required this.products,
      required this.categoryCode,
      required this.pages,
      required this.initCatalog,
      required this.typePage,
      required this.appBarCubit});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/admin/products/$categoryCode',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: CatalogProductContent(
          category: category,
          products: products,
          initCatalog: (int minPrice, int maxPrice, String valueSort, int page,
                  String typePage, String searchReq, String category) =>
              initCatalog(minPrice, maxPrice, valueSort, page, typePage,
                  searchReq, category),
          pages: pages,
          typePage: typePage,
          categoryCode: categoryCode,
        ));
  }
}
