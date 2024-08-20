import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/presentation/pages/homescreen/widgets/product_card.dart';
import 'package:shophimikat/presentation/pages/lkScreen/widgets/referals_screen.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  final InfoApp infoApp;
  final List<Product> products;
  final Map infoUser;
  const HomeScreen(
      {super.key,
      required this.infoApp,
      required this.products,
      required this.infoUser});

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? Wrapperpage(
            routName: '/',
            onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
            content: ListView(children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Column(
                    children: [
                      SizedBox(
                          width: 90.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  imageUrl: infoApp.onebanner))),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                          height: 25.sp,
                          child: ListView.builder(
                              itemCount: AppInfo.categorys.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Map categor = AppInfo.categorys[index];
                                return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          '/catalog/${categor['key']}');
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 7),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: 2),
                                          color: AppColors.white),
                                      child: AppText(
                                          text: categor['title'],
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary)),
                                    ));
                              })),
                      SizedBox(
                        height: 2.h,
                      ),
                      InkWell(
                          onTap: () => infoUser['countRefs'] >= 0
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReferalsScreen(
                                            referalscount:
                                                infoUser['countRefs'],
                                            referalcode:
                                                infoUser['referalcode'],
                                          )),
                                )
                              : {},
                          child: SizedBox(
                              width: 90.w,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      imageUrl: infoApp.twobanner)))),
                      SizedBox(
                        height: 2.h,
                      ),
                      AppText(
                          text: "АКЦИИ",
                          textStyle: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                          width: 90.w,
                          height: 35.h,
                          child: ListView.builder(
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCardHome(
                                  product: products[index],
                                );
                              }))
                    ],
                  ))
            ]),
          )
        : Wrapperpage(
            routName: '/',
            onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
            content: SizedBox(
              width: 65.w,
              height: 70.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 25.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              CachedNetworkImage(imageUrl: infoApp.onebanner))),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                      width: 25.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              CachedNetworkImage(imageUrl: infoApp.twobanner)))
                ],
              ),
            ));
  }
}
