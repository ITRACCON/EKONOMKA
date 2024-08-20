import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class BasketProductCard extends StatelessWidget {
  final BasketProduct basketProduct;

  final void Function(int productID, int amount) addAmountBasketProduct;
  final void Function(int productID, int amount) minusAmountBasketProduct;
  final void Function(int productID) remuveProductBasket;
  const BasketProductCard(
      {super.key,
      required this.basketProduct,
      required this.addAmountBasketProduct,
      required this.minusAmountBasketProduct,
      required this.remuveProductBasket});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile(context) ? 90.w : 33.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(isMobile(context) ? 2.w : 1.w),
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
              height: isMobile(context) ? 15.h : 12.h,
              width: isMobile(context) ? 22.w : 5.w,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                errorWidget: (context, a, b) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.onBoardingNoPhoto,
                      height: isMobile(context) ? 15.h : 12.h,
                      width: isMobile(context) ? 22.w : 5.w,
                      fit: BoxFit.cover,
                    )),
                placeholder: (context, url) => Container(
                  height: isMobile(context) ? 15.h : 12.h,
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
            width: 2.w,
          ),
          Container(
              constraints:
                  BoxConstraints(maxHeight: isMobile(context) ? 15.h : 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: isMobile(context) ? 58.w : 24.w,
                    child: AppText(
                        text: basketProduct.product!.title,
                        textAlign: TextAlign.left,
                        textStyle: TextStyle(
                            fontSize: isMobile(context) ? 9.sp : 3.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      width: isMobile(context) ? 58.w : 24.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (basketProduct.amount < 2) {
                                      remuveProductBasket(
                                          basketProduct.product!.article);
                                    } else {
                                      minusAmountBasketProduct(
                                          basketProduct.product!.article, 1);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          color: AppColors.primary),
                                      child: AppText(
                                          text: '-',
                                          textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 14.sp
                                                : 3.sp,
                                            color: AppColors.white,
                                          )))),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  color: AppColors.primary.withOpacity(0.3),
                                  child: AppText(
                                      text: '${basketProduct.amount}',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 14.sp : 3.sp,
                                          color: AppColors.black))),
                              InkWell(
                                  onTap: () {
                                    addAmountBasketProduct(
                                        basketProduct.product!.article, 1);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                          color: AppColors.primary),
                                      child: AppText(
                                          text: '+',
                                          textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 14.sp
                                                : 3.sp,
                                            color: AppColors.white,
                                          )))),
                            ],
                          ),
                          basketProduct.product!.sale == 0
                              ? AppText(
                                  text:
                                      '${(basketProduct.product!.price * basketProduct.amount).round()} ₽',
                                  textAlign: TextAlign.left,
                                  textStyle: TextStyle(
                                      fontSize:
                                          isMobile(context) ? 14.sp : 4.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(
                                        text:
                                            '${(basketProduct.product!.price * basketProduct.amount).round()} ₽',
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: isMobile(context)
                                                ? 12.sp
                                                : 2.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary)),
                                    AppText(
                                        text:
                                            '${(basketProduct.product!.salePrice * basketProduct.amount).round()} ₽',
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 14.sp
                                                : 4.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary))
                                  ],
                                ),
                        ],
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
