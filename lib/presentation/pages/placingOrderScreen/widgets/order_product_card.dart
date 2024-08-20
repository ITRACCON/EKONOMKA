import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class OrderProductCard extends StatelessWidget {
  final BasketProduct basketProduct;

  const OrderProductCard({super.key, required this.basketProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile(context) ? 90.w : 29.w,
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      padding: EdgeInsets.all(isMobile(context) ? 2.w : 0.5.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderPrimary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: isMobile(context) ? 15.h : 11.h,
              width: isMobile(context) ? 22.w : 5.w,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                errorWidget: (context, a, b) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.onBoardingNoPhoto,
                      height: isMobile(context) ? 15.h : 11.h,
                      width: isMobile(context) ? 22.w : 5.w,
                      fit: BoxFit.cover,
                    )),
                placeholder: (context, url) => Container(
                  height: isMobile(context) ? 15.h : 10.h,
                  width: isMobile(context) ? 22.w : 5.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.black.withOpacity(0.2)),
                  child: SizedBox(
                      width: 3.w, child: const CircularProgressIndicator()),
                ),
                imageUrl: basketProduct.product!.photo,
              ),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Container(
              constraints:
                  BoxConstraints(maxHeight: isMobile(context) ? 15.h : 11.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: isMobile(context) ? 58.w : 20.w,
                    child: AppText(
                        text: basketProduct.product!.title,
                        textAlign: TextAlign.left,
                        textStyle: TextStyle(
                            fontSize: isMobile(context) ? 9.sp : 3.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: isMobile(context) ? 58.w : 20.w,
                    child: AppText(
                        text:
                            '${(basketProduct.product!.price * basketProduct.amount).round()} ₽',
                        textAlign: TextAlign.left,
                        textStyle: TextStyle(
                            fontSize: isMobile(context) ? 14.sp : 3.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
