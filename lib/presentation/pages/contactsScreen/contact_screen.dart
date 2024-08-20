import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? Wrapperpage(
            routName: '/',
            onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
            content: ListView(children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Column(children: [
                    AppText(
                      text: 'Контактная Информация',
                      textStyle: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Column(children: [
                      ListTile(
                          leading: Icon(
                            Icons.phone_in_talk_rounded,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                          title: InkWell(
                              onTap: () {
                                launchUrlString("tel://+79190817171");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text: '+79190817171',
                                  textStyle: TextStyle(fontSize: 14.sp)))),
                      ListTile(
                          leading: Icon(
                            Icons.telegram_outlined,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                          title: InkWell(
                              onTap: () {
                                launchUrlString("https://t.me/ysnpru");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text: 'Менеджер в тг (@ysnpru)',
                                  textStyle: TextStyle(fontSize: 14.sp)))),
                      ListTile(
                          leading: Image.asset(
                            AppImages.vkLogo,
                            width: 20.sp,
                          ),
                          title: InkWell(
                              onTap: () {
                                launchUrlString("https://vk.com/ekonomka71");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text:
                                      'Группа вконтакте (https://vk.com/ekonomka71)',
                                  textStyle: TextStyle(fontSize: 14.sp))))
                    ])
                  ]))
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
                  AppText(
                    text: 'Контактная Информация',
                    textStyle: TextStyle(fontSize: 3.sp),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Column(
                    children: [
                      ListTile(
                          leading: Icon(
                            Icons.phone_in_talk_rounded,
                            size: 3.sp,
                            color: AppColors.primary,
                          ),
                          title: InkWell(
                              onTap: () {
                                launchUrlString("tel://+79190817171");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text: '+79190817171',
                                  textStyle: TextStyle(fontSize: 3.sp)))),
                      ListTile(
                          leading: Icon(
                            Icons.telegram_outlined,
                            size: 3.sp,
                            color: AppColors.primary,
                          ),
                          title: InkWell(
                              onTap: () {
                                launchUrlString("https://t.me/ysnpru");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text: 'Менеджер в тг (@ysnpru)',
                                  textStyle: TextStyle(fontSize: 3.sp)))),
                      ListTile(
                          title: InkWell(
                              onTap: () {
                                launchUrlString("https://vk.com/ekonomka71");
                              },
                              child: AppText(
                                  textAlign: TextAlign.left,
                                  text:
                                      'Группа вконтакте (https://vk.com/ekonomka71)',
                                  textStyle: TextStyle(fontSize: 3.sp))))
                    ],
                  )
                ],
              ),
            ));
  }
}
