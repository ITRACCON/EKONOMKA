import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class LoadingScreen extends StatelessWidget {
  final String title;
  final String text;
  final String routName;
  final bool backPage;

  const LoadingScreen({
    super.key,
    required this.text,
    required this.title,
    required this.routName,
    required this.backPage,
  });

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: routName,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: backPage,
        resizeToAvoidBottomInset: true,
        content: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(top: 2.h),
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                  value: null,
                  strokeWidth: 5.0,
                )),
            SizedBox(
              height: 4.h,
            ),
            AppText(
                text: title,
                textStyle: TextStyle(
                    fontSize: isMobile(context) ? 14.sp : 4.sp,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 2.h,
            ),
            AppText(
                text: text,
                textStyle:
                    TextStyle(fontSize: isMobile(context) ? 12.sp : 3.sp)),
          ],
        )));
  }
}
