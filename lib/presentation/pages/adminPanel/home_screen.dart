import 'package:flutter/material.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/catalog_products/add_product_screen.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/catalog_products/catalog_cubit_controller.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/promocode_cubit_controller.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/settigs_screen.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/stats_screen.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.admin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        content: Container(
            height: 90.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  AppText(
                      text: 'Админ панель',
                      textStyle: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StatsScreen()),
                                ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Статистика',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddProductScreen()),
                                ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Добавить товар',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CatalogProductAdminCubitControllerScreen(
                                            category: 'avtokhimiya',
                                          )),
                                ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Редактировать/Удалить товар',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CatalogPromocodesAdminCubitControllerScreen()),
                                ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Промокоды',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingScreen()),
                                ),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Настройки',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                        InkWell(
                            onTap: () => Navigator.pushNamed(context, '/'),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.buttonPrimary),
                              child: AppText(
                                  text: 'Перейти в магазин',
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AppText(
                      text: 'Ver. 1.1.2',
                      textStyle: TextStyle(
                          fontSize: 10.sp, color: AppColors.textSecondary))
                ]))));
  }
}
