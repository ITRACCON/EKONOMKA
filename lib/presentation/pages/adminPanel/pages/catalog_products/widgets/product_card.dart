import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/catalog_products/edit_product_screen.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class ProductCardAdmin extends StatelessWidget {
  final void Function(int article) deleteProduct;
  final Product? product;
  final String searchText;
  const ProductCardAdmin({
    super.key,
    required this.product,
    required this.searchText,
    required this.deleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile(context) ? 42.w : 13.w,
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
            height: isMobile(context) ? 25.h : 22.h,
            width: isMobile(context) ? 37.w : 12.8.w,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              errorWidget: (context, a, b) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppImages.onBoardingNoPhoto,
                    height: isMobile(context) ? 25.h : 22.h,
                    width: isMobile(context) ? 37.w : 12.8.w,
                    fit: BoxFit.fill,
                  )),
              placeholder: (context, url) => Container(
                height: isMobile(context) ? 25.h : 22.h,
                width: isMobile(context) ? 37.w : 12.8.w,
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
              searchText != 'NO'
                  ? AppHighlightText(
                      text: product!.title,
                      highlightText: searchText,
                      textStyle:
                          TextStyle(fontSize: isMobile(context) ? 11.sp : 3.sp),
                      highlightTextStyle: TextStyle(
                          fontSize: isMobile(context) ? 11.sp : 3.sp,
                          backgroundColor: AppColors.primary,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    )
                  : AppText(
                      text: product!.title,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      textStyle: TextStyle(
                          fontSize: isMobile(context) ? 11.sp : 3.sp)),
              AppText(
                  text: 'Артикул: ${product!.article}',
                  textAlign: TextAlign.left,
                  textStyle: TextStyle(
                      fontSize: isMobile(context) ? 8.sp : 2.sp,
                      color: AppColors.textSecondary)),
              SizedBox(height: 0.8.h),
              Column(
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
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: isMobile(context) ? 10.sp : 4.sp,
                                    color: AppColors.textSecondary)),
                            AppText(
                                text: '${product!.salePrice} ₽',
                                textStyle: TextStyle(
                                    fontSize: isMobile(context) ? 12.sp : 4.sp,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                  InkWell(
                    onTap: () {
                      deleteProduct(product!.article);
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.textRed,
                          borderRadius: BorderRadius.circular(5)),
                      child: AppText(
                        text: "Удалить",
                        textStyle: TextStyle(
                            fontSize: isMobile(context) ? 10.sp : 2.sp,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                                  product: product!,
                                )),
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.buttonPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      child: AppText(
                        text: "Редактировать",
                        textStyle: TextStyle(
                            fontSize: isMobile(context) ? 10.sp : 2.sp,
                            color: AppColors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
