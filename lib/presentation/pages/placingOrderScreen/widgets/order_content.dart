import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/models/info_model.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/enums.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/debouncer.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/basket_model.dart';
import 'package:shophimikat/presentation/cubits/promocodeCubit/promocode_cubit.dart';
import 'package:shophimikat/presentation/pages/placingOrderScreen/widgets/order_product_card.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

class OrderContent extends StatefulWidget {
  final List<BasketProduct> basketProducts;
  final void Function(
      List<BasketProduct> basketProducts,
      String fio,
      String date,
      Gender? gender,
      String phone,
      String email,
      String adress,
      int skidkaBonus,
      int skidkaPromocode,
      String promocode,
      XFile? checkImage) placingOrder;
  final InfoApp infoApp;
  const OrderContent(
      {super.key,
      required this.basketProducts,
      required this.placingOrder,
      required this.infoApp});

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  final WebAppInitData webAppInitData = tg.initDataUnsafe;
  getSumaOrder() {
    double sumaOrder = 0;
    widget.basketProducts.forEach((product) => sumaOrder += product.amount *
        (product.product!.sale == 0
            ? product.product!.price
            : product.product!.salePrice));
    return sumaOrder;
  }

  dynamic user;

  getCoinUser() async {
    final userC = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    setState(() {
      user = userC;
    });
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _promoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  XFile? image;

  DateTime? date;
  Gender? _gender = Gender.man;
  bool spisanieBalov = false;
  int skidkaBonus = 0;

  bool promocodeGood = false;
  bool promocodeError = false;
  int skidkaPromocode = 0;

  late PromocodeCubit promocodeCubit;

  final _debouncer = Debouncer(milliseconds: 1000);

  Color bgTextFormField = AppColors.inputPrimary;
  Color border = Colors.white;

  @override
  void initState() {
    super.initState();
    getCoinUser();
    promocodeCubit = PromocodeCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PromocodeCubit, PromocodeState>(
        bloc: promocodeCubit,
        listener: (context, state) {
          if (state is Success) {
            setState(() {
              promocodeError = false;
              promocodeGood = true;
              skidkaPromocode =
                  ((getSumaOrder() * int.parse(state.result['skidka'])) / 100)
                      .round();
              bgTextFormField = AppColors.inputSuccess;
              border = AppColors.borderSuccess;
            });
          } else if (state is Error) {
            setState(() {
              promocodeGood = false;
              promocodeError = true;
              bgTextFormField = AppColors.borderError;
              border = AppColors.inputError;
            });
          }
        },
        child: isMobile(context)
            ? ListView(children: [
                Container(
                  alignment: Alignment.center,
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.5),
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                text: 'Информация о заказе',
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                    text: 'Товаров',
                                    textStyle: TextStyle(fontSize: 11.sp)),
                                AppText(
                                    text: '${widget.basketProducts.length}',
                                    textStyle: TextStyle(fontSize: 11.sp)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                    text: 'Стоимость заказа',
                                    textStyle: TextStyle(fontSize: 11.sp)),
                                AppText(
                                    text: '${getSumaOrder().round()} ₽',
                                    textStyle: TextStyle(fontSize: 11.sp)),
                              ],
                            ),
                            promocodeGood
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                          text:
                                              'Промокод (${_promoController.text})',
                                          textStyle:
                                              TextStyle(fontSize: 11.sp)),
                                      AppText(
                                          text: '- ${skidkaPromocode} ₽',
                                          textStyle:
                                              TextStyle(fontSize: 11.sp)),
                                    ],
                                  )
                                : Container(),
                            spisanieBalov
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                          text: 'Списание баллов',
                                          textStyle:
                                              TextStyle(fontSize: 11.sp)),
                                      AppText(
                                          text: '- ${skidkaBonus.toString()} ₽',
                                          textStyle:
                                              TextStyle(fontSize: 11.sp)),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 1.h,
                            ),
                            Column(
                              children: [
                                const Divider(
                                  height: 2,
                                  color: AppColors.primary,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                        text: 'Итого',
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold)),
                                    AppText(
                                        text:
                                            '${getSumaOrder().round() - skidkaBonus - skidkaPromocode} ₽',
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 90.w,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AppText(
                            textAlign: TextAlign.left,
                            text: widget.infoApp.details,
                            textStyle: TextStyle(fontSize: 12.sp)),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Form(
                                key: _formKey,
                                child: SizedBox(
                                    width: 80.w,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Input(
                                              onChanged: () {},
                                              title: "ФИО",
                                              controller: _fioController,
                                              keyboardType: TextInputType.text),
                                          InputDate(
                                            title: 'Дата рождения',
                                            onComplete: (datee) {
                                              setState(() {
                                                date = datee;
                                              });
                                            },
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                AppText(
                                                    textAlign: TextAlign.left,
                                                    text: 'Пол',
                                                    textStyle: TextStyle(
                                                        fontSize:
                                                            isMobile(context)
                                                                ? 12.sp
                                                                : 3.sp)),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: const Text('Муж'),
                                                      leading: Radio<Gender>(
                                                        activeColor:
                                                            AppColors.primary,
                                                        value: Gender.man,
                                                        groupValue: _gender,
                                                        onChanged:
                                                            (Gender? value) {
                                                          setState(() {
                                                            _gender = value;
                                                          });
                                                        },
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: const Text('Жен'),
                                                      leading: Radio<Gender>(
                                                        activeColor:
                                                            AppColors.primary,
                                                        value: Gender.women,
                                                        groupValue: _gender,
                                                        onChanged:
                                                            (Gender? value) {
                                                          setState(() {
                                                            _gender = value;
                                                          });
                                                        },
                                                      ),
                                                    )),
                                                  ],
                                                )
                                              ]),
                                          Input(
                                              onChanged: () {},
                                              title: "Номер телефона",
                                              controller: _phoneController,
                                              maxLength: 11,
                                              keyboardType:
                                                  TextInputType.phone),
                                          Input(
                                              onChanged: () {},
                                              title: "Email",
                                              controller: _emailController,
                                              maxLength: 50,
                                              keyboardType:
                                                  TextInputType.emailAddress),
                                          Input(
                                              onChanged: () {},
                                              title: "Адрес доставки",
                                              controller: _adressController,
                                              keyboardType: TextInputType.text),
                                          Input(
                                            bgTextFormField: bgTextFormField,
                                            border: border,
                                            title: "Промокод",
                                            controller: _promoController,
                                            keyboardType: TextInputType.text,
                                            onChanged: () {
                                              _debouncer.run(() {
                                                promocodeCubit.checkPromo(
                                                    _promoController.text);
                                              });
                                            },
                                          ),
                                          promocodeError
                                              ? AppText(
                                                  text: 'Промокод не найден',
                                                  textStyle: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: AppColors.textRed))
                                              : Container(),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                  text: "Баллов",
                                                  textStyle: TextStyle(
                                                      fontSize: 11.sp)),
                                              AppText(
                                                  text: user != null
                                                      ? user.coin.toString()
                                                      : '0',
                                                  textStyle: TextStyle(
                                                      fontSize: 11.sp))
                                            ],
                                          ),
                                          CheckboxListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: AppText(
                                                textAlign: TextAlign.left,
                                                text: 'Списать баллы',
                                                textStyle:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                              activeColor: AppColors.primary,
                                              value: spisanieBalov,
                                              onChanged: (value) {
                                                setState(() {
                                                  spisanieBalov = value!;
                                                  skidkaBonus = user.coin >
                                                          getSumaOrder().round()
                                                      ? (getSumaOrder() * 0.3)
                                                          .round()
                                                      : user.coin;
                                                });
                                              }),
                                        ]))),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    XFile? image_old = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      image = image_old;
                                    });
                                  },
                                  child: AppText(
                                    textAlign: TextAlign.left,
                                    text: "Прикрепить чек",
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.textSecondary),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: image != null ? image!.name : '',
                                textStyle: TextStyle(
                                    fontSize: 12.sp, color: AppColors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (_phoneController.text.isEmpty ||
                                    _fioController.text.isEmpty ||
                                    _phoneController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _adressController.text.isEmpty ||
                                    image == null ||
                                    date == null) {
                                  QuickAlert.show(
                                      width: isMobile(context) ? 80.w : 25.w,
                                      context: context,
                                      type: QuickAlertType.error,
                                      title:
                                          'Вы не заполнили поля или не прикрепили чек',
                                      confirmBtnText: AppTexts.close,
                                      confirmBtnColor: AppColors.primary,
                                      confirmBtnTextStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 12.sp : 3.sp,
                                          color: AppColors.white));
                                } else if (_formKey.currentState!.validate()) {
                                  widget.placingOrder(
                                      widget.basketProducts,
                                      _fioController.text,
                                      '${date!.day}.${date!.month}.${date!.year}',
                                      _gender!,
                                      _phoneController.text,
                                      _emailController.text,
                                      _adressController.text,
                                      skidkaBonus,
                                      skidkaPromocode,
                                      _promoController.text,
                                      image);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 10),
                                width: 90.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primary),
                                child: AppText(
                                    text: 'Оформить заказ',
                                    textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white)),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ])
            : Container(
                width: 70.w,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 35.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                          key: _formKey,
                          child: SizedBox(
                              width: 33.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Input(
                                      onChanged: () {},
                                      title: "ФИО",
                                      controller: _fioController,
                                      keyboardType: TextInputType.text),
                                  InputDate(
                                    title: 'Дата рождения',
                                    onComplete: (datee) {
                                      setState(() {
                                        date = datee;
                                      });
                                    },
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        AppText(
                                            textAlign: TextAlign.left,
                                            text: 'Пол',
                                            textStyle: TextStyle(
                                                fontSize: isMobile(context)
                                                    ? 12.sp
                                                    : 3.sp)),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: const Text('Муж'),
                                              leading: Radio<Gender>(
                                                activeColor: AppColors.primary,
                                                value: Gender.man,
                                                groupValue: _gender,
                                                onChanged: (Gender? value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                            )),
                                            Expanded(
                                                child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: const Text('Жен'),
                                              leading: Radio<Gender>(
                                                activeColor: AppColors.primary,
                                                value: Gender.women,
                                                groupValue: _gender,
                                                onChanged: (Gender? value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                            )),
                                          ],
                                        )
                                      ]),
                                  Input(
                                      onChanged: () {},
                                      title: "Номер телефона",
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone),
                                  Input(
                                      onChanged: () {},
                                      title: "Email",
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress),
                                  Input(
                                      onChanged: () {},
                                      title: "Адрес доставки",
                                      controller: _adressController,
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            XFile? image_old =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              image = image_old;
                                            });
                                          },
                                          child: AppText(
                                            textAlign: TextAlign.left,
                                            text: "Прикрепить чек",
                                            textStyle: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.textSecondary),
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      AppText(
                                        text: image != null ? image!.name : '',
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.black),
                                      )
                                    ],
                                  ),
                                ],
                              ))),
                    ),
                    Container(
                      width: 30.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        AppText(
                            text: 'Оформление заказа',
                            textStyle: TextStyle(fontSize: 4.sp)),
                        Divider(
                          height: 1.h,
                          color: AppColors.borderPrimary,
                        ),
                        SizedBox(
                            height: 38.h,
                            child: ListView(children: [
                              Column(
                                  children: widget.basketProducts
                                      .map((BasketProduct basketProduct) {
                                return OrderProductCard(
                                    basketProduct: basketProduct,
                                    key: ValueKey(basketProduct.product!.id));
                              }).toList())
                            ])),
                        Divider(
                          height: 1.h,
                          color: AppColors.borderPrimary,
                        ),
                        Form(
                            key: _formKey2,
                            child: Column(
                              children: [
                                Input(
                                  bgTextFormField: bgTextFormField,
                                  border: border,
                                  title: "Промокод",
                                  controller: _promoController,
                                  keyboardType: TextInputType.text,
                                  onChanged: () {
                                    _debouncer.run(() {
                                      promocodeCubit
                                          .checkPromo(_promoController.text);
                                    });
                                  },
                                ),
                                promocodeError
                                    ? AppText(
                                        text: 'Промокод не найден',
                                        textStyle: TextStyle(
                                            fontSize: 2.sp,
                                            color: AppColors.textRed))
                                    : Container(),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                        text: "Баллов",
                                        textStyle: TextStyle(fontSize: 3.sp)),
                                    AppText(
                                        text: user.coin.toString(),
                                        textStyle: TextStyle(fontSize: 3.sp))
                                  ],
                                ),
                                CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: AppText(
                                      textAlign: TextAlign.left,
                                      text: 'Списать баллы',
                                      textStyle: TextStyle(fontSize: 3.sp),
                                    ),
                                    activeColor: AppColors.primary,
                                    value: spisanieBalov,
                                    onChanged: (value) {
                                      setState(() {
                                        spisanieBalov = value!;
                                        skidkaBonus =
                                            user.coin > getSumaOrder().round()
                                                ? (getSumaOrder() * 0.3).round()
                                                : user.coin;
                                      });
                                    }),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: 'Стоимость заказа',
                                textStyle: TextStyle(fontSize: 3.sp)),
                            AppText(
                                text: '${getSumaOrder().round()}',
                                textStyle: TextStyle(fontSize: 3.sp)),
                          ],
                        ),
                        promocodeGood
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                      text:
                                          'Промокод (${_promoController.text})',
                                      textStyle: TextStyle(fontSize: 3.sp)),
                                  AppText(
                                      text: '- ${skidkaPromocode} ₽',
                                      textStyle: TextStyle(fontSize: 3.sp)),
                                ],
                              )
                            : Container(),
                        spisanieBalov
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                      text: 'Списание баллов',
                                      textStyle: TextStyle(fontSize: 3.sp)),
                                  AppText(
                                      text: '- ${skidkaBonus.toString()} ₽',
                                      textStyle: TextStyle(fontSize: 3.sp)),
                                ],
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: 'Итого',
                                textStyle: TextStyle(
                                    fontSize: 3.sp,
                                    fontWeight: FontWeight.bold)),
                            AppText(
                                text:
                                    '${getSumaOrder().round() - skidkaBonus - skidkaPromocode} ₽',
                                textStyle: TextStyle(
                                    fontSize: 3.sp,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (_phoneController.text.isEmpty ||
                                  _fioController.text.isEmpty ||
                                  _phoneController.text.isEmpty ||
                                  _emailController.text.isEmpty ||
                                  _adressController.text.isEmpty ||
                                  date == null) {
                              } else if (_formKey.currentState!.validate()) {
                                widget.placingOrder(
                                    widget.basketProducts,
                                    _fioController.text,
                                    '${date!.day}.${date!.month}.${date!.year}',
                                    _gender!,
                                    _phoneController.text,
                                    _emailController.text,
                                    _adressController.text,
                                    skidkaBonus,
                                    skidkaPromocode,
                                    _promoController.text,
                                    image);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              width: 30.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primary),
                              child: AppText(
                                  text: 'Оформить заказ',
                                  textStyle: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white)),
                            ))
                      ]),
                    )
                  ],
                )));
  }
}
