import 'package:flutter/material.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class SuccessOreder extends StatelessWidget {
  const SuccessOreder({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/order',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        content: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.onBoardingNoPhoto, width: 60.w),
            Container(
                width: 80.w,
                padding: EdgeInsets.only(top: 2.h),
                child: AppText(
                  text:
                      'Ваш заказ успешно оформлен. Ожидайте подтверждения и информацию о доставке на указанный вами контактный номер.',
                  textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                ))
          ],
        )));
  }
}
