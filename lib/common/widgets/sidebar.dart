import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/user_content.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

class Sidebar extends StatelessWidget {
  final String routName;
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  Sidebar({super.key, required this.routName});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 3.h),
        child: Column(
          children: [
            const UserContent(),
            SizedBox(
              height: 2.h,
            ),
            const Divider(
              height: 3,
              color: AppColors.primary,
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                MenuButton(
                  title: 'Главная',
                  routNameActive: routName,
                  routName: AppRoutes.home,
                ),
                Column(
                    children: AppInfo.categorys.map((category) {
                  return MenuButton(
                    title: category['title'],
                    routNameActive: routName,
                    routName: '/catalog/${category['key']}',
                  );
                }).toList()),
                MenuButton(
                  title: 'Контакты',
                  routNameActive: routName,
                  routName: AppRoutes.contact,
                ),
                SizedBox(
                  height: 4.h,
                ),
                AppText(
                    text: 'ver. 1.0.4',
                    textStyle: TextStyle(
                        fontSize: 10.sp, color: AppColors.textSecondary))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class SidebarDesctop extends StatelessWidget {
  final String routName;
  const SidebarDesctop({super.key, required this.routName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuButton(
            title: 'Главная',
            routNameActive: routName,
            routName: '/',
          ),
          Column(
              children: AppInfo.categorys.map((category) {
            return MenuButton(
              title: category['title'],
              routNameActive: routName,
              routName: '/catalog/${category['key']}',
            );
          }).toList()),
          MenuButton(
            title: 'Контакты',
            routNameActive: routName,
            routName: AppRoutes.contact,
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final String routNameActive;
  final String routName;
  const MenuButton(
      {super.key,
      required this.title,
      required this.routNameActive,
      required this.routName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, routName);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: AppText(
                      textAlign: TextAlign.left,
                      text: title,
                      textStyle: TextStyle(
                          color: routNameActive == routName
                              ? AppColors.primary
                              : AppColors.black,
                          fontSize: isMobile(context) ? 15.sp : 3.sp))),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: isMobile(context) ? 20.sp : 3.sp,
                color: routNameActive == routName
                    ? AppColors.primary
                    : AppColors.black,
              )
            ],
          ),
        ));
  }
}
