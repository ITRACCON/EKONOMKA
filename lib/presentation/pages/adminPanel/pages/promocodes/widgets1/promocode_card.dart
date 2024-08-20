import 'package:flutter/material.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/edit_promocode_screen.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class PromocodeCardAdmin extends StatelessWidget {
  final void Function(int id) deletePromocode;
  final PromocodeModel? promocode;
  const PromocodeCardAdmin({
    super.key,
    required this.promocode,
    required this.deletePromocode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isMobile(context) ? 86.w : 13.w,
        padding:
            isMobile(context) ? EdgeInsets.all(2.w) : EdgeInsets.all(0.5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderPrimary),
            color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    text: promocode!.promocode,
                    textAlign: TextAlign.start,
                    textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 0.5.h),
                AppText(
                    textAlign: TextAlign.start,
                    text: 'Скидака: ${promocode!.selProcent}%',
                    textStyle: TextStyle(
                        fontSize: 11.sp, color: AppColors.textSecondary)),
              ],
            )),
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditPromocodeScreen(promocode: promocode!)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: AppColors.buttonPrimary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.edit_document,
                      size: 11.sp,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                InkWell(
                  onTap: () {
                    deletePromocode(promocode!.id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: AppColors.textRed,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.delete_forever,
                      size: 11.sp,
                      color: AppColors.textWhite,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
