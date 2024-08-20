import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/presentation/cubits/infoAppCubit/infoapp_cubit.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late InfoAppCubit cubit;

  final TextEditingController _percentController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color backgroundColor = Color(0xFFf5f5f5);
  Color borderColor = Color(0xFFf5f5f5);
  @override
  void initState() {
    super.initState();
    cubit = InfoAppCubit()..init();
  }

  XFile? onebanner;

  XFile? twobanner;
  Uint8List? onebannerBytes;

  changeStyleFiled(status) {
    switch (status) {
      case 'ERROR':
        setState(() {
          backgroundColor = AppColors.inputError;
          borderColor = AppColors.borderError;
        });
        break;
      case 'SUCCESS':
        setState(() {
          backgroundColor = AppColors.inputSuccess;
          borderColor = AppColors.borderSuccess;
        });
        break;

      default:
        setState(() {
          backgroundColor = AppColors.white;
          borderColor = AppColors.white;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.admin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: LoaderOverlay(
            child: BlocListener<InfoAppCubit, InfoAppState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is Success) {
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Данные обновленны',
                        confirmBtnText: AppTexts.okay,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  } else if (state is Error) {
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ошибка при обновлении данных',
                        confirmBtnText: AppTexts.close,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  } else if (state is Loading) {
                    context.loaderOverlay.show();
                  }
                },
                child: BlocBuilder<InfoAppCubit, InfoAppState>(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is Intial) {
                        _percentController.text =
                            state.infoApp.percentRefs.toString();
                        _detailsController.text = state.infoApp.details;
                        return SafeArea(
                            child: SizedBox(
                                width: 100.w,
                                height: 100.h - kToolbarHeight,
                                child: ListView(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 2.h),
                                    child: Column(
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5.w),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Form(
                                                    key: _formKey,
                                                    child: SizedBox(
                                                        width: 90.w,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Input(
                                                              title:
                                                                  "Реферальный бонус (в %)",
                                                              bgTextFormField:
                                                                  backgroundColor,
                                                              border:
                                                                  borderColor,
                                                              controller:
                                                                  _percentController,
                                                              maxLength: 3,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              onChanged: () {},
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Input(
                                                              title:
                                                                  'Реквизиты',
                                                              bgTextFormField:
                                                                  backgroundColor,
                                                              border:
                                                                  borderColor,
                                                              controller:
                                                                  _detailsController,
                                                              maxLength: 200,
                                                              maxLines: 6,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: () {},
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    width: 90.w,
                                                                    child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child: CachedNetworkImage(
                                                                            imageUrl: onebanner != null
                                                                                ? onebanner!.path
                                                                                : state.infoApp.onebanner))),
                                                                SizedBox(
                                                                  height: 1.h,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      XFile?
                                                                          image_old =
                                                                          await ImagePicker()
                                                                              .pickImage(source: ImageSource.gallery);
                                                                      setState(
                                                                          () {
                                                                        onebanner =
                                                                            image_old;
                                                                      });
                                                                    },
                                                                    child:
                                                                        AppText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text:
                                                                          'Заменить первый баннер',
                                                                      textStyle: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              AppColors.primary),
                                                                    )),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    width: 90.w,
                                                                    child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child: CachedNetworkImage(
                                                                            imageUrl: twobanner != null
                                                                                ? twobanner!.path
                                                                                : state.infoApp.twobanner))),
                                                                SizedBox(
                                                                  height: 1.h,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      XFile?
                                                                          image_old =
                                                                          await ImagePicker()
                                                                              .pickImage(source: ImageSource.gallery);
                                                                      setState(
                                                                          () {
                                                                        twobanner =
                                                                            image_old;
                                                                      });
                                                                    },
                                                                    child:
                                                                        AppText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text:
                                                                          'Заменить второй баннер',
                                                                      textStyle: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              AppColors.primary),
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ))),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if (_detailsController
                                                            .text.isEmpty ||
                                                        _percentController
                                                            .text.isEmpty) {
                                                    } else if (_formKey
                                                        .currentState!
                                                        .validate()) {
                                                      cubit.editInfo(
                                                          int.parse(
                                                              _percentController
                                                                  .text),
                                                          _detailsController
                                                              .text,
                                                          onebanner,
                                                          twobanner);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 7,
                                                        horizontal: 10),
                                                    width: 90.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            AppColors.primary),
                                                    child: AppText(
                                                        text: 'Сохранить',
                                                        textStyle: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .white)),
                                                  ))
                                            ])
                                      ],
                                    ),
                                  )
                                ])));
                      }
                      return Container();
                    }))));
  }
}
