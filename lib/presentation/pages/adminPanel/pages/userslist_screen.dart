import 'package:flutter/material.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class UserslistScreen extends StatelessWidget {
  final List<UserModel> users;
  const UserslistScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.admin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(children: [
              AppText(
                  text: "Пользователи",
                  textStyle:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 1.h,
              ),
              users.isEmpty
                  ? ListView(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        height: 85.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  AppImages.onBoardingNoPhoto,
                                  width: 75.w,
                                ),
                                SizedBox(height: 2.h),
                                AppText(
                                    text: "Список пользователей пуст",
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 2.h),
                                AppText(
                                    text:
                                        "На данный момент нет зарегистрированных пользователей на сайте.",
                                    textStyle: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ])
                  : Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 0.5.h),
                              width: 90.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  users[index].typeAcc == 'web'
                                      ? Row(children: [
                                          Icon(
                                            Icons.phone_in_talk_outlined,
                                            size: 12.sp,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AppText(
                                              textAlign: TextAlign.left,
                                              text: users[index].phone,
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500))
                                        ])
                                      : Row(children: [
                                          Icon(
                                            Icons.send_outlined,
                                            size: 12.sp,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AppText(
                                              textAlign: TextAlign.left,
                                              text: users[index].userTgFl,
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500))
                                        ]),
                                  users[index].typeAcc == 'tg'
                                      ? Row(children: [
                                          Icon(
                                            Icons.phone_in_talk_outlined,
                                            size: 11.sp,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AppText(
                                              textAlign: TextAlign.left,
                                              text: users[index].phone == 'null'
                                                  ? 'Не указан'
                                                  : users[index].phone,
                                              textStyle:
                                                  TextStyle(fontSize: 11.sp))
                                        ])
                                      : Container(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      users[index].typeAcc == 'tg'
                                          ? AppText(
                                              textAlign: TextAlign.left,
                                              text:
                                                  '${users[index].userTgName.isEmpty ? 'Без логина' : '@${users[index].userTgName}'} | ID: ${users[index].userTgId}',
                                              textStyle: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.grey))
                                          : Container(),
                                      AppText(
                                          textAlign: TextAlign.left,
                                          text:
                                              ' | Баллов: ${users[index].coin}',
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }))
            ])));
  }
}
