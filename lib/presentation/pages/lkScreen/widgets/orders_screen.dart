import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/common/widgets/accordion.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatelessWidget {
  final List<OrderUser> orders;
  const OrdersScreen({super.key, required this.orders});

  getSumaOrder(index) {
    double sumaOrder = 0;
    orders[index]
        .order
        .forEach((order) => sumaOrder += order.amount * order.product!.price);
    return sumaOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/lk/orders',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: true,
        resizeToAvoidBottomInset: true,
        content: Container(
          width: 100.w,
          height: 95.h,
          padding: EdgeInsets.only(top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                  text: "Мои заказы", textStyle: TextStyle(fontSize: 16.sp)),
              Divider(
                height: 2.h,
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 95.w,
                          margin: EdgeInsets.symmetric(vertical: 0.5.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: 'Заказ №${orders[index].orderId}',
                                  textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 1.h,
                              ),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: 'Доставка на адрес',
                                  textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600)),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: orders[index].adress,
                                  textStyle: TextStyle(fontSize: 10.sp)),
                              SizedBox(
                                height: 2.h,
                              ),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: 'Получатель заказа',
                                  textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600)),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: orders[index].fio,
                                  textStyle: TextStyle(fontSize: 10.sp)),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: orders[index].phone,
                                  textStyle: TextStyle(fontSize: 10.sp)),
                              AppText(
                                  textAlign: TextAlign.left,
                                  text: orders[index].email,
                                  textStyle: TextStyle(fontSize: 10.sp)),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                      textAlign: TextAlign.left,
                                      text:
                                          '${orders[index].order.length == 1 ? '${orders[index].order.length} Товар' : orders[index].order.length < 5 ? '${orders[index].order.length} Товара' : '${orders[index].order.length} Товаров'}',
                                      textStyle: TextStyle(fontSize: 10.sp)),
                                  AppText(
                                      textAlign: TextAlign.left,
                                      text:
                                          '${getSumaOrder(index).toString()} ₽',
                                      textStyle: TextStyle(fontSize: 10.sp)),
                                ],
                              ),
                              orders[index].skidkaBonus > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                            textAlign: TextAlign.left,
                                            text: 'Списанно баллов',
                                            textStyle:
                                                TextStyle(fontSize: 10.sp)),
                                        AppText(
                                            textAlign: TextAlign.left,
                                            text:
                                                '- ${orders[index].skidkaBonus} ₽',
                                            textStyle:
                                                TextStyle(fontSize: 10.sp)),
                                      ],
                                    )
                                  : Container(),
                              orders[index].skidkaPromocode > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                            textAlign: TextAlign.left,
                                            text: 'Использование промокода',
                                            textStyle:
                                                TextStyle(fontSize: 10.sp)),
                                        AppText(
                                            textAlign: TextAlign.left,
                                            text:
                                                '- ${orders[index].skidkaPromocode} ₽',
                                            textStyle:
                                                TextStyle(fontSize: 10.sp)),
                                      ],
                                    )
                                  : Container(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                      textAlign: TextAlign.left,
                                      text: 'Итого',
                                      textStyle: TextStyle(fontSize: 10.sp)),
                                  AppText(
                                      textAlign: TextAlign.left,
                                      text:
                                          '${getSumaOrder(index) - orders[index].skidkaPromocode - orders[index].skidkaBonus} ₽',
                                      textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.borderPrimary,
                              ),
                              Accordion(
                                  title: 'Товары',
                                  child: Column(
                                    children: orders[index].order.map((order) {
                                      return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 0.5.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: isMobile(context)
                                                      ? 13.h
                                                      : 11.h,
                                                  width: isMobile(context)
                                                      ? 22.w
                                                      : 5.w,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      errorWidget: (context, a,
                                                              b) =>
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.asset(
                                                                AppImages
                                                                    .onBoardingNoPhoto,
                                                                height: isMobile(
                                                                        context)
                                                                    ? 13.h
                                                                    : 11.h,
                                                                width: isMobile(
                                                                        context)
                                                                    ? 22.w
                                                                    : 5.w,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                                height: isMobile(
                                                                        context)
                                                                    ? 13.h
                                                                    : 11.h,
                                                                width: isMobile(
                                                                        context)
                                                                    ? 22.w
                                                                    : 5.w,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                7),
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2)),
                                                                child: SizedBox(
                                                                    width: 3.w,
                                                                    child:
                                                                        const CircularProgressIndicator()),
                                                              ),
                                                      imageUrl:
                                                          order.product!.photo),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Container(
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          isMobile(context)
                                                              ? 13.h
                                                              : 11.h),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        width: isMobile(context)
                                                            ? 60.w
                                                            : 20.w,
                                                        child: AppText(
                                                            text: order
                                                                .product!.title,
                                                            textAlign:
                                                                TextAlign.left,
                                                            textStyle: TextStyle(
                                                                fontSize: isMobile(
                                                                        context)
                                                                    ? 11.sp
                                                                    : 3.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        width: isMobile(context)
                                                            ? 60.w
                                                            : 20.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            AppText(
                                                                text:
                                                                    '${order.amount} шт.',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: isMobile(
                                                                          context)
                                                                      ? 10.sp
                                                                      : 3.sp,
                                                                )),
                                                            AppText(
                                                                text:
                                                                    '${(order.product!.price * order.amount).round()} ₽',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: isMobile(
                                                                          context)
                                                                      ? 10.sp
                                                                      : 3.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ));
                                    }).toList(),
                                  ))
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
