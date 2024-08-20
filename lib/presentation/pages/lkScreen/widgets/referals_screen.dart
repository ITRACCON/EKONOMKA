import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class ReferalsScreen extends StatelessWidget {
  final int referalscount;
  final String referalcode;
  const ReferalsScreen(
      {super.key, required this.referalscount, required this.referalcode});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/lk/ref',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: true,
        resizeToAvoidBottomInset: true,
        content: Container(
          width: 100.w,
          height: 95.h,
          padding: EdgeInsets.only(top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(
                  text: "Партнерская программа",
                  textStyle: TextStyle(fontSize: 16.sp)),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: 100.w,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                            textAlign: TextAlign.left,
                            text: 'Рефералов',
                            textStyle: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        AppText(
                            text: referalscount.toString(),
                            textStyle: TextStyle(fontSize: 12.sp))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                            textAlign: TextAlign.left,
                            text: 'Реферальный код',
                            textStyle: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        AppText(
                            text: referalcode,
                            textStyle: TextStyle(fontSize: 12.sp))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            textAlign: TextAlign.left,
                            text: 'Реферальная ссылка',
                            textStyle: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 1.h,
                        ),
                        AppText(
                            textAlign: TextAlign.left,
                            text:
                                'https://t.me/ekonomka71_bot?start=$referalcode',
                            textStyle: TextStyle(fontSize: 12.sp))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '$referalcode'))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Код успешно скопирован")));
                  });
                },
                child: Container(
                  width: 90.w,
                  padding: EdgeInsets.symmetric(vertical: 0.75.h),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3)),
                  child: AppText(
                      text: 'Скопировать код',
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 1.h),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                          text:
                              'https://t.me/ekonomka71_bot?start=$referalcode'))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Ссылка успешно скопированна")));
                  });
                },
                child: Container(
                  width: 90.w,
                  padding: EdgeInsets.symmetric(vertical: 0.75.h),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3)),
                  child: AppText(
                      text: 'Скопировать ссылку',
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                width: 90.w,
                child: AppText(
                    textAlign: TextAlign.left,
                    text: '''Реферальная программа «Экономка»
Присоединяйтесь к нашей реферальной программе и получайте бонусы за каждого друга, который зарегистрируется на нашем сайте!
Как это работает?
1. Зарегистрируйтесь на сайте и получите уникальную реферальную ссылку.
2. Поделитесь этой ссылкой с друзьями и знакомыми.
3. Каждый, кто зарегистрируется на сайте по вашей ссылке, получит скидку на первый заказ.
4. Вы будете получать бонусы за каждого привлечённого клиента. И с каждой покупки вашего друга. 
Бонусы можно использовать для оплаты заказов на сайте.
Присоединяйтесь к нашей реферальной программе и начните зарабатывать бонусы уже сегодня!''',
                    textStyle: TextStyle(
                        fontSize: 10.sp, color: AppColors.textSecondary)),
              )
            ],
          ),
        ));
  }
}
