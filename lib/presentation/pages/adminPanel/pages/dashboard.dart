import 'package:flutter/material.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/orderlist_screen.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/userslist_screen.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatelessWidget {
  final List<UserModel> users;
  final List<OrderUser> orderUsers;
  const Dashboard({super.key, required this.users, required this.orderUsers});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(children: [
            AppText(
                text: AppTexts.stats,
                textStyle:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 2.h,
            ),
            Column(children: [
              Container(
                width: 90.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.buttonPurple.withOpacity(0.2)),
                          child: Icon(
                            Icons.people_alt_outlined,
                            size: 42.sp,
                            color: AppColors.buttonPurple,
                          ),
                        ),
                        AppText(
                            textAlign: TextAlign.right,
                            text: users.length.toString(),
                            textStyle: TextStyle(
                                fontSize: 26.sp, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    AppText(
                        textAlign: TextAlign.right,
                        text: AppTexts.users,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                        ))
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserslistScreen(
                                users: users,
                              )),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    width: 90.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: AppColors.buttonPurple),
                    child: AppText(
                        text: AppTexts.openList,
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white)),
                  )),
            ]),
            SizedBox(
              height: 2.h,
            ),
            Column(children: [
              Container(
                width: 90.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.buttonGreen.withOpacity(0.2)),
                          child: Icon(
                            Icons.description_outlined,
                            size: 42.sp,
                            color: AppColors.buttonGreen,
                          ),
                        ),
                        AppText(
                            textAlign: TextAlign.right,
                            text: orderUsers.length.toString(),
                            textStyle: TextStyle(
                                fontSize: 26.sp, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    AppText(
                        textAlign: TextAlign.right,
                        text: AppTexts.orders,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                        ))
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderlistScreen(
                                orders: orderUsers,
                              )),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    width: 90.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: AppColors.buttonGreen),
                    child: AppText(
                        text: AppTexts.openList,
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white)),
                  )),
            ]),
          ]))
    ]);
  }
}
