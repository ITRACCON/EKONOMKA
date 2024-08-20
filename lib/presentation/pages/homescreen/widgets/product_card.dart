import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:sizer/sizer.dart';

class ProductCardHome extends StatelessWidget {
  final Product product;
  const ProductCardHome({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: isMobile(context) ? 33.w : 13.w,
      padding: isMobile(context) ? EdgeInsets.all(2.w) : EdgeInsets.all(0.5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderPrimary),
          color: AppColors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: isMobile(context) ? 18.h : 22.h,
            width: isMobile(context) ? 31.w : 12.8.w,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              errorWidget: (context, a, b) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppImages.onBoardingNoPhoto,
                    height: isMobile(context) ? 18.h : 22.h,
                    width: isMobile(context) ? 31.w : 12.8.w,
                    fit: BoxFit.fill,
                  )),
              placeholder: (context, url) => Container(
                height: isMobile(context) ? 18.h : 22.h,
                width: isMobile(context) ? 31.w : 12.8.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.black.withOpacity(0.2)),
                child: SizedBox(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primary,
                  )),
                  height: 3.w,
                  width: 3.w,
                ),
              ),
              imageUrl: product!.photo,
            ),
          ),
          SizedBox(height: 0.5.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: product!.title,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  textStyle:
                      TextStyle(fontSize: isMobile(context) ? 11.sp : 3.sp)),
              AppText(
                  text: 'Артикул: ${product!.article}',
                  textAlign: TextAlign.left,
                  textStyle: TextStyle(
                      fontSize: isMobile(context) ? 8.sp : 2.sp,
                      color: AppColors.textSecondary)),
              SizedBox(height: 0.8.h),
              isMobile(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        product!.sale == 0
                            ? AppText(
                                text: '${product!.price} ₽',
                                textStyle: TextStyle(
                                    fontSize: isMobile(context) ? 12.sp : 4.sp,
                                    fontWeight: FontWeight.bold))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AppText(
                                      text: '${product!.price} ₽',
                                      textStyle: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize:
                                              isMobile(context) ? 10.sp : 4.sp,
                                          color: AppColors.textSecondary)),
                                  AppText(
                                      text: '${product!.salePrice} ₽',
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 12.sp : 4.sp,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                            text: '${product!.price} ₽',
                            textStyle: TextStyle(
                                fontSize: isMobile(context) ? 12.sp : 4.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
            ],
          ),
        ],
      ),
    );
  }
}
