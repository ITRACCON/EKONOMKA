import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class EditUserScreen extends StatefulWidget {
  final UserModel user;
  final UserCubit cubit;
  const EditUserScreen({super.key, required this.user, required this.cubit});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _phoneController.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/lk/edti',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        backPage: true,
        resizeToAvoidBottomInset: true,
        content: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                      text: 'Мои данные',
                      textStyle: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      alignment: Alignment.center,
                      color: AppColors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Form(
                          key: _formKey,
                          child: SizedBox(
                              width: isMobile(context) ? 80.w : 20.w,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        controller: _confirmPasswordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        maxLength: 25)
                                  ])))),
                  SizedBox(
                    height: 2.h,
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
                                    fontSize: isMobile(context) ? 12.sp : 3.sp,
                                    color: AppColors.white));
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
                                  fontSize: isMobile(context) ? 13.sp : 4.sp,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
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
                                    fontSize: isMobile(context) ? 12.sp : 3.sp,
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
                                  title: AppTexts.errorConfirmPass,
                                  confirmBtnText: AppTexts.close,
                                  confirmBtnColor: AppColors.primary,
                                  confirmBtnTextStyle: TextStyle(
                                      fontSize:
                                          isMobile(context) ? 12.sp : 3.sp,
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
                                  fontSize: isMobile(context) ? 13.sp : 4.sp,
                                  color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ])));
  }
}
