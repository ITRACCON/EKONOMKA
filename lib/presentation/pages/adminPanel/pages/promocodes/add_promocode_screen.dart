import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/presentation/cubits/adminCubit/admin_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class AddPromocodeScreen extends StatefulWidget {
  const AddPromocodeScreen({super.key});

  @override
  State<AddPromocodeScreen> createState() => _AddPromocodeScreenState();
}

class _AddPromocodeScreenState extends State<AddPromocodeScreen> {
  late AdminCubit cubit;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _skidkaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color backgroundColor = Color(0xFFf5f5f5);
  Color borderColor = Color(0xFFf5f5f5);
  @override
  void initState() {
    super.initState();
    cubit = AdminCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.admin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        backPage: true,
        content: LoaderOverlay(
            child: BlocListener<AdminCubit, AdminState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is Success) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Промокод создан',
                        confirmBtnText: AppTexts.okay,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                    _titleController.clear();
                    _skidkaController.clear();
                  } else if (state is Error) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ошибка при создании промокода',
                        confirmBtnText: AppTexts.close,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  }
                },
                child: SafeArea(
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
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Input(
                                                      title: 'Промокод',
                                                      bgTextFormField:
                                                          backgroundColor,
                                                      border: borderColor,
                                                      controller:
                                                          _titleController,
                                                      maxLength: 10,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: () {},
                                                    ),
                                                    Input(
                                                      title: 'Скидка в %',
                                                      bgTextFormField:
                                                          backgroundColor,
                                                      border: borderColor,
                                                      controller:
                                                          _skidkaController,
                                                      maxLength: 3,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: () {},
                                                    ),
                                                  ],
                                                ))),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            if (_titleController.text.isEmpty ||
                                                _skidkaController
                                                    .text.isEmpty) {
                                              QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title: 'Поля не заполнены',
                                                  confirmBtnText:
                                                      AppTexts.close,
                                                  confirmBtnColor:
                                                      AppColors.primary,
                                                  confirmBtnTextStyle:
                                                      TextStyle(
                                                          fontSize: 12.sp,
                                                          color:
                                                              AppColors.white));
                                            } else if (_formKey.currentState!
                                                .validate()) {
                                              context.loaderOverlay.show();
                                              cubit.addPromocode(
                                                  _titleController.text,
                                                  int.parse(
                                                      _skidkaController.text));
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 10),
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.primary),
                                            child: AppText(
                                                text: 'Создать промокоды',
                                                textStyle: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white)),
                                          ))
                                    ])
                              ],
                            ),
                          )
                        ]))))));
  }
}
