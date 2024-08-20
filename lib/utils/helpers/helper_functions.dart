import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class AppHelperFunctions {
  static void showSnackBar(String message, Color bgSnackBar) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          backgroundColor: bgSnackBar,
          content: AppText(
            text: message,
            textStyle: TextStyle(
                fontSize: isMobile(Get.context!) ? 3.sp : 12.sp,
                color: AppColors.white),
          )),
    );
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd.MMM.yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String getCategoryTitle(String key) {
    List<Map> categorys = AppInfo.categorys;
    String title = '';
    for (var category in categorys) {
      if (category['key'] == key) {
        title = category['title'];
      }
    }
    return title;
  }
}
