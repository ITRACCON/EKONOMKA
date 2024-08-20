import 'package:flutter/material.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/widgets1/catalog_content.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class ListPromocodeAdminScreen extends StatelessWidget {
  final List<PromocodeModel> promocodes;
  final int pages;
  final String typePage;
  final void Function(int page, String typePage) initPromocodes;
  const ListPromocodeAdminScreen(
      {super.key,
      required this.promocodes,
      required this.pages,
      required this.initPromocodes,
      required this.typePage});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/promocodes',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: PromocodesContent(
          promocodes: promocodes,
          initPromocodes: (int page, String typePage) =>
              initPromocodes(page, typePage),
          pages: pages,
          typePage: typePage,
        ));
  }
}
