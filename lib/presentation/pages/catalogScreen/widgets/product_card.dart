import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  final void Function(int article) buyProduct;
  final void Function(int article) addCountProduct;
  final void Function(int article) minusCountsProduct;
  final void Function(int article) remuveProductBasket;
  final Product? product;
  final String searchText;
  final bool isBasket;
  final int count;
  const ProductCard(
      {super.key,
      required this.product,
      required this.buyProduct,
      required this.searchText,
      this.isBasket = true,
      this.count = 0,
      required this.addCountProduct,
      required this.minusCountsProduct,
      required this.remuveProductBasket});

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
                                          decoration: TextDecoration.lineThrough,
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
                        isBasket
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      count > 1
                                          ? minusCountsProduct(product!.article)
                                          : remuveProductBasket(
                                              product!.article);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5))),
                                      child: AppText(
                                        text: "-",
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 10.sp
                                                : 3.sp,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    color: AppColors.primary.withOpacity(0.7),
                                    child: AppText(
                                      text: count.toString(),
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 10.sp : 3.sp,
                                          color: AppColors.white),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      addCountProduct(product!.article);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: AppText(
                                        text: "+",
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 10.sp
                                                : 3.sp,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  buyProduct(product!.article);
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: AppText(
                                    text: "Купить",
                                    textStyle: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 10.sp : 2.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              )
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
                        isBasket
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      count > 1
                                          ? minusCountsProduct(product!.article)
                                          : remuveProductBasket(
                                              product!.article);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5))),
                                      child: AppText(
                                        text: "-",
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 10.sp
                                                : 3.sp,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    color: AppColors.primary.withOpacity(0.7),
                                    child: AppText(
                                      text: count.toString(),
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 10.sp : 3.sp,
                                          color: AppColors.white),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      addCountProduct(product!.article);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: AppText(
                                        text: "+",
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 10.sp
                                                : 3.sp,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  buyProduct(product!.article);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: AppText(
                                    text: "Купить",
                                    textStyle: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 10.sp : 3.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              )
                      ],
                    )
            ],
          ),
        ],
      ),
    );
  }
}
