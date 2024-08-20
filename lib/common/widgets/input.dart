import 'package:date_format_field/date_format_field.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class Input extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final void Function() onChanged;
  final Color bgTextFormField;
  final Color border;
  const Input(
      {super.key,
      required this.title,
      required this.controller,
      required this.keyboardType,
      this.maxLength = 100,
      this.readOnly = false,
      this.obscureText = false,
      this.maxLines = 1,
      required this.onChanged,
      this.bgTextFormField = AppColors.inputPrimary,
      this.border = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
              textAlign: TextAlign.left,
              text: title,
              textStyle: TextStyle(fontSize: isMobile(context) ? 12.sp : 3.sp)),
          SizedBox(
            height: 0.5.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: bgTextFormField,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: border, width: 2)),
            child: TextFormField(
              readOnly: readOnly,
              maxLines: maxLines,
              maxLength: maxLength,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: (value) {
                onChanged();
              },
              style: TextStyle(fontSize: isMobile(context) ? 12.sp : 3.sp),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                fillColor: Colors.grey,
                hintText: '',
                counterText: '',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    fontSize: isMobile(context) ? 12.sp : 3.sp),
              ),
              controller: controller,
            ),
          )
        ]);
  }
}

class InputDate extends StatelessWidget {
  final String title;
  final void Function(DateTime date) onComplete;
  const InputDate({super.key, required this.title, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          AppText(
              textAlign: TextAlign.left,
              text: title,
              textStyle: TextStyle(fontSize: isMobile(context) ? 12.sp : 3.sp)),
          SizedBox(
            height: 0.5.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColors.inputPrimary,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white, width: 2)),
            child: DateFormatField(
              type: DateFormatType.type4,
              addCalendar: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onComplete: (date) {
                onComplete(date!);
              },
            ),
          )
        ]);
  }
}
