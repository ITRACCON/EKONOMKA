import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/presentation/pages/lkScreen/widgets/edit_screen.dart';
import 'package:shophimikat/presentation/pages/lkScreen/widgets/orders_screen.dart';
import 'package:shophimikat/presentation/pages/lkScreen/widgets/referals_screen.dart';
import 'package:shophimikat/common/widgets/accordion.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LkContent extends StatefulWidget {
  final Map lk;
  final UserModel user;
  final UserCubit cubit;
  LkContent(
      {super.key, required this.lk, required this.user, required this.cubit});

  @override
  State<LkContent> createState() => _LkContentState();
}

class _LkContentState extends State<LkContent> {
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<OrderUser> orders = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.user.phone;
    orders = widget.lk['orders'];
  }

  getSumaOrder(index) {
    double sumaOrder = 0;
    orders[index]
        .order
        .forEach((order) => sumaOrder += order.amount * order.product!.price);
    return sumaOrder;
  }

  showModalBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            height: 20.h,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    launchUrlString("tel://+79190817171");
                  },
                  child: Image.asset(
                    AppImages.phoneLogo,
                    width: 25.w,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://t.me/ysnpru'));
                  },
                  child: Image.asset(
                    AppImages.tgLogo,
                    width: 25.w,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? Container(
            height: 90.h,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              children: [
                AppText(
                    text: 'Личный кабинет',
                    textStyle: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      webAppInitData!.hash != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText(
                                    text: 'Логин тг',
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600)),
                                AppText(
                                    text: webAppInitData!.user?.username ??
                                        'Без логина',
                                    textStyle: TextStyle(fontSize: 14.sp))
                              ],
                            )
                          : Container(),
                      webAppInitData.hash != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText(
                                    text: 'ID тг',
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600)),
                                AppText(
                                    text: webAppInitData.user!.id.toString(),
                                    textStyle: TextStyle(fontSize: 14.sp))
                              ],
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              text: 'Номер телефона',
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          AppText(
                              text: widget.user.phone != null
                                  ? widget.user.phone
                                  : 'Не указан',
                              textStyle: TextStyle(fontSize: 14.sp))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              text: 'Бонусных баллов',
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          AppText(
                              text: widget.user.coin.toString(),
                              textStyle: TextStyle(fontSize: 14.sp))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              text: 'Заказов',
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          AppText(
                              text: widget.lk['orders'].length.toString(),
                              textStyle: TextStyle(fontSize: 14.sp))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersScreen(
                              orders: widget.lk['orders'],
                            )),
                  ),
                  child: Container(
                      width: 100.w,
                      color: AppColors.white,
                      padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                      text: 'Мои заказы',
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Divider(
                            height: 1.h,
                            color: AppColors.textSecondary.withOpacity(0.7),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReferalsScreen(
                              referalscount: widget.lk['countRefs'],
                              referalcode: widget.user.referalcode,
                            )),
                  ),
                  child: Container(
                      width: 100.w,
                      color: AppColors.white,
                      padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.people_outline_rounded,
                                    size: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                      text: 'Партнерская программа',
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Divider(
                            height: 1.h,
                            color: AppColors.textSecondary.withOpacity(0.7),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserScreen(
                              user: widget.user,
                              cubit: widget.cubit,
                            )),
                  ),
                  child: Container(
                      width: 100.w,
                      color: AppColors.white,
                      padding: EdgeInsets.only(
                          right: 5.w, left: 5.w, top: 1.h, bottom: 1.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    size: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                      text: 'Мои данные',
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                  onTap: () {
                    showModalBottom();
                  },
                  child: Container(
                      width: 100.w,
                      color: AppColors.white,
                      padding: EdgeInsets.only(
                          right: 5.w, left: 5.w, top: 1.h, bottom: 1.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    size: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(
                                      text: 'Связаться с нами',
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(height: 3.h),
                webAppInitData!.hash == null
                    ? InkWell(
                        onTap: () {
                          widget.cubit.logout();
                          Navigator.pushNamed(context, '/');
                        },
                        child: Container(
                          width: 90.w,
                          padding: EdgeInsets.symmetric(vertical: 0.75.h),
                          decoration: BoxDecoration(
                              color: AppColors.textRed,
                              borderRadius: BorderRadius.circular(3)),
                          child: AppText(
                              text: 'Выйти',
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      )
                    : Container()
              ],
            ),
          )
        : Container(
            width: 70.w,
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    Container(
                      width: 30.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          webAppInitData!.hash != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                        text: 'Логин тг',
                                        textStyle: TextStyle(
                                            fontSize: 3.sp,
                                            fontWeight: FontWeight.w600)),
                                    AppText(
                                        text: webAppInitData!.user?.username ??
                                            'Без логина',
                                        textStyle: TextStyle(fontSize: 3.sp))
                                  ],
                                )
                              : Container(),
                          webAppInitData.hash != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                        text: 'ID тг',
                                        textStyle: TextStyle(
                                            fontSize: 3.sp,
                                            fontWeight: FontWeight.w600)),
                                    AppText(
                                        text:
                                            webAppInitData.user!.id.toString(),
                                        textStyle: TextStyle(fontSize: 3.sp))
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                  text: 'Номер телефона',
                                  textStyle: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.w600)),
                              AppText(
                                  text: widget.user.phone != null
                                      ? widget.user.phone
                                      : 'Не указан',
                                  textStyle: TextStyle(fontSize: 3.sp))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                  text: 'Бонусных баллов',
                                  textStyle: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.w600)),
                              AppText(
                                  text: widget.user.coin.toString(),
                                  textStyle: TextStyle(fontSize: 3.sp))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                  text: 'Заказов',
                                  textStyle: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.w600)),
                              AppText(
                                  text: widget.lk['orders'].length.toString(),
                                  textStyle: TextStyle(fontSize: 3.sp))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                        width: 30.w,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.w,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppText(
                                          textAlign: TextAlign.left,
                                          text: 'Рефералов',
                                          textStyle: TextStyle(
                                              fontSize: 3.sp,
                                              fontWeight: FontWeight.w500)),
                                      AppText(
                                          text:
                                              widget.lk['countRefs'].toString(),
                                          textStyle: TextStyle(fontSize: 3.sp))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppText(
                                          textAlign: TextAlign.left,
                                          text: 'Реферальный код',
                                          textStyle: TextStyle(
                                              fontSize: 3.sp,
                                              fontWeight: FontWeight.w500)),
                                      AppText(
                                          text: widget.user.referalcode,
                                          textStyle: TextStyle(fontSize: 3.sp))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          textAlign: TextAlign.left,
                                          text: 'Реферальная ссылка',
                                          textStyle: TextStyle(
                                              fontSize: 3.sp,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      AppText(
                                          textAlign: TextAlign.left,
                                          text:
                                              'https://t.me/tb_itracoon_project_bot?start=${widget.user.referalcode}',
                                          textStyle: TextStyle(fontSize: 3.sp))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 1.h),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                        text: '${widget.user.referalcode}'))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Код успешно скопирован")));
                                });
                              },
                              child: Container(
                                width: 90.w,
                                padding: EdgeInsets.symmetric(vertical: 0.75.h),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(3)),
                                child: AppText(
                                    text: 'Скопировать код',
                                    textStyle: TextStyle(
                                        fontSize: 3.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            'https://t.me/tb_itracoon_project_bot?start=${widget.user.referalcode}'))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Ссылка успешно скопированна")));
                                });
                              },
                              child: Container(
                                width: 90.w,
                                padding: EdgeInsets.symmetric(vertical: 0.75.h),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(3)),
                                child: AppText(
                                    text: 'Скопировать ссылку',
                                    textStyle: TextStyle(
                                        fontSize: 3.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            )
                          ],
                        )),
                    SizedBox(height: 1.h),
                    Container(
                      width: 30.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Form(
                            key: _formKey,
                            child: SizedBox(
                                width: isMobile(context) ? 80.w : 20.w,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Input(
                                          onChanged: () {},
                                          title: "Номер телефона",
                                          controller: _phoneController,
                                          keyboardType: TextInputType.phone,
                                          maxLength: 11),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Input(
                                          onChanged: () {},
                                          title: "Пароль",
                                          controller: _passwordController,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          maxLength: 25),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Input(
                                          onChanged: () {},
                                          title: "Подтверждение пароля",
                                          controller:
                                              _confirmPasswordController,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          maxLength: 25)
                                    ]))),
                        SizedBox(
                          height: 1.h,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (_phoneController.text.isEmpty) {
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: AppTexts.emptyInputs,
                                        confirmBtnText: AppTexts.close,
                                        confirmBtnColor: AppColors.primary,
                                        confirmBtnTextStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 12.sp : 3.sp,
                                          color: AppColors.white,
                                        ));
                                  } else {
                                    widget.cubit.updatePhone(
                                      _phoneController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  width: 80.w,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: AppText(
                                      text: 'Обновить номер',
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 13.sp : 3.sp,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_passwordController.text.isEmpty ||
                                      _confirmPasswordController.text.isEmpty) {
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: AppTexts.emptyInputs,
                                        confirmBtnText: AppTexts.close,
                                        confirmBtnColor: AppColors.primary,
                                        confirmBtnTextStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 12.sp
                                                : 3.sp,
                                            color: AppColors.white));
                                  } else {
                                    if (_passwordController.text ==
                                        _confirmPasswordController.text) {
                                      widget.cubit.updatePassword(
                                        _passwordController.text,
                                      );
                                    } else {
                                      QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title:
                                              AppTexts.errorConfirmPass,
                                          confirmBtnText: AppTexts.close,
                                          confirmBtnColor: AppColors.primary,
                                          confirmBtnTextStyle: TextStyle(
                                              fontSize: isMobile(context)
                                                  ? 12.sp
                                                  : 3.sp,
                                              color: AppColors.white));
                                    }
                                  }
                                },
                                child: Container(
                                  width: 80.w,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: AppText(
                                      text: 'Обновить пароль',
                                      textStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 13.sp : 3.sp,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ])
                      ]),
                    ),
                  ]),
                  Column(
                    children: [
                      Container(
                        width: 30.w,
                        height: 50.h,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                                text: "Мои заказы",
                                textStyle: TextStyle(fontSize: 4.sp)),
                            Divider(
                              height: 1.h,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: orders.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: 30.w,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.5.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.borderPrimary,
                                                width: 2)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text:
                                                    'Заказ №${orders[index].orderId}',
                                                textStyle: TextStyle(
                                                    fontSize: 3.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: 'Доставка на адрес',
                                                textStyle: TextStyle(
                                                    fontSize: 3.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: orders[index].adress,
                                                textStyle:
                                                    TextStyle(fontSize: 3.sp)),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: 'Получатель заказа',
                                                textStyle: TextStyle(
                                                    fontSize: 3.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: orders[index].fio,
                                                textStyle:
                                                    TextStyle(fontSize: 3.sp)),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: orders[index].phone,
                                                textStyle:
                                                    TextStyle(fontSize: 3.sp)),
                                            AppText(
                                                textAlign: TextAlign.left,
                                                text: orders[index].email,
                                                textStyle:
                                                    TextStyle(fontSize: 3.sp)),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                    textAlign: TextAlign.left,
                                                    text:
                                                        '${orders[index].order.length == 1 ? '${orders[index].order.length} Товар' : orders[index].order.length < 5 ? '${orders[index].order.length} Товара' : '${orders[index].order.length} Товаров'}',
                                                    textStyle: TextStyle(
                                                        fontSize: 3.sp)),
                                                AppText(
                                                    textAlign: TextAlign.left,
                                                    text:
                                                        '${getSumaOrder(index).toString()} ₽',
                                                    textStyle: TextStyle(
                                                        fontSize: 3.sp)),
                                              ],
                                            ),
                                            orders[index].skidkaBonus > 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text:
                                                              'Списанно баллов',
                                                          textStyle: TextStyle(
                                                              fontSize: 3.sp)),
                                                      AppText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text:
                                                              '- ${orders[index].skidkaBonus} ₽',
                                                          textStyle: TextStyle(
                                                              fontSize: 3.sp)),
                                                    ],
                                                  )
                                                : Container(),
                                            orders[index].skidkaPromocode > 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text:
                                                              'Использование промокода',
                                                          textStyle: TextStyle(
                                                              fontSize: 3.sp)),
                                                      AppText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text:
                                                              '- ${orders[index].skidkaPromocode} ₽',
                                                          textStyle: TextStyle(
                                                              fontSize: 3.sp)),
                                                    ],
                                                  )
                                                : Container(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                    textAlign: TextAlign.left,
                                                    text: 'Итого',
                                                    textStyle: TextStyle(
                                                        fontSize: 3.sp)),
                                                AppText(
                                                    textAlign: TextAlign.left,
                                                    text:
                                                        '${getSumaOrder(index) - orders[index].skidkaPromocode - orders[index].skidkaBonus} ₽',
                                                    textStyle: TextStyle(
                                                        fontSize: 3.sp,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ),
                                            Divider(
                                              height: 2.h,
                                              color: AppColors.borderPrimary,
                                            ),
                                            Accordion(
                                                title: 'Товары',
                                                child: Column(
                                                  children: orders[index]
                                                      .order
                                                      .map((order) {
                                                    return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    0.5.h),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: SizedBox(
                                                                height: isMobile(
                                                                        context)
                                                                    ? 13.h
                                                                    : 11.h,
                                                                width: isMobile(
                                                                        context)
                                                                    ? 22.w
                                                                    : 5.w,
                                                                child: CachedNetworkImage(
                                                                    fit: BoxFit.fill,
                                                                    errorWidget: (context, a, b) => ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: Image.asset(
                                                                          AppImages
                                                                              .onBoardingNoPhoto,
                                                                          height: isMobile(context)
                                                                              ? 13.h
                                                                              : 11.h,
                                                                          width: isMobile(context)
                                                                              ? 22.w
                                                                              : 5.w,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                                    placeholder: (context, url) => Container(
                                                                          height: isMobile(context)
                                                                              ? 13.h
                                                                              : 11.h,
                                                                          width: isMobile(context)
                                                                              ? 22.w
                                                                              : 5.w,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(7),
                                                                              color: Colors.black.withOpacity(0.2)),
                                                                          child: SizedBox(
                                                                              width: 3.w,
                                                                              child: const CircularProgressIndicator()),
                                                                        ),
                                                                    imageUrl: order.product!.photo),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 1.w,
                                                            ),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    maxHeight: isMobile(
                                                                            context)
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
                                                                          Alignment
                                                                              .topCenter,
                                                                      width: isMobile(
                                                                              context)
                                                                          ? 60.w
                                                                          : 19.w,
                                                                      child: AppText(
                                                                          text: order
                                                                              .product!
                                                                              .title,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          textStyle: TextStyle(
                                                                              fontSize: isMobile(context) ? 11.sp : 3.sp,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      width: isMobile(
                                                                              context)
                                                                          ? 60.w
                                                                          : 19.w,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          AppText(
                                                                              text: '${order.amount} шт.',
                                                                              textAlign: TextAlign.left,
                                                                              textStyle: TextStyle(
                                                                                fontSize: isMobile(context) ? 10.sp : 3.sp,
                                                                              )),
                                                                          AppText(
                                                                              text: '${(order.product!.price * order.amount).round()} ₽',
                                                                              textAlign: TextAlign.left,
                                                                              textStyle: TextStyle(
                                                                                fontSize: isMobile(context) ? 10.sp : 3.sp,
                                                                                fontWeight: FontWeight.w600,
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
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 30.w,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            AppText(
                                text: "Связаться с нами",
                                textStyle: TextStyle(fontSize: 4.sp)),
                            Divider(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    launchUrlString("tel://79190817171");
                                  },
                                  child: Image.asset(
                                    AppImages.phoneLogo,
                                    width: 5.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse('https://t.me/ysnpru'));
                                  },
                                  child: Image.asset(
                                    AppImages.tgLogo,
                                    width: 5.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ]));
  }
}
