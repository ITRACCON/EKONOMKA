import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late UserCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = UserCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: AppRoutes.signin,
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        offLeftMenu: true,
        offHeader: true,
        backPage: true,
        content: LoaderOverlay(
            child: BlocListener<UserCubit, UserState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is Success) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: state.text,
                      confirmBtnText: AppTexts.okay,
                      confirmBtnColor: AppColors.buttonPrimary,
                      confirmBtnTextStyle:
                          TextStyle(fontSize: 12.sp, color: AppColors.white),
                      onConfirmBtnTap: () {
                        Navigator.pushNamed(context, AppRoutes.home);
                      },
                    );
                    _phoneController.clear();
                    _passwordController.clear();
                  } else if (state is Error) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: state.text,
                        confirmBtnText: AppTexts.close,
                        confirmBtnColor: AppColors.buttonPrimary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormLogin(
                        cubit: cubit,
                      )
                    ],
                  ),
                ))));
  }
}

class FormLogin extends StatefulWidget {
  final UserCubit cubit;
  const FormLogin({super.key, required this.cubit});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          AppText(
              text: AppTexts.titleSignIn,
              textStyle: TextStyle(fontSize: isMobile(context) ? 14.sp : 5.sp)),
          SizedBox(
            height: 2.h,
          ),
          Form(
              key: _formKey,
              child: SizedBox(
                  width: isMobile(context) ? 80.w : 20.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Input(
                            onChanged: () {},
                            title: AppTexts.phoneNo,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 11),
                        SizedBox(
                          height: 1.h,
                        ),
                        Input(
                            onChanged: () {},
                            title: AppTexts.password,
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            maxLength: 25),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (_passwordController.text.isEmpty ||
                                    _phoneController.text.isEmpty) {
                                  QuickAlert.show(
                                      width: isMobile(context) ? 80.w : 25.w,
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Вы не заполнили поля и',
                                      confirmBtnText: AppTexts.close,
                                      confirmBtnColor: AppColors.primary,
                                      confirmBtnTextStyle: TextStyle(
                                          fontSize:
                                              isMobile(context) ? 12.sp : 3.sp,
                                          color: AppColors.white));
                                } else {
                                  context.loaderOverlay.show();
                                  widget.cubit.loginUser(_phoneController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.buttonPrimary,
                                    borderRadius: BorderRadius.circular(7)),
                                child: AppText(
                                    text: AppTexts.signIn,
                                    textStyle: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 13.sp : 4.sp,
                                        color: Colors.white)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.signup);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.buttonPrimary,
                                    borderRadius: BorderRadius.circular(7)),
                                child: AppText(
                                    text: AppTexts.createAccount,
                                    textStyle: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 13.sp : 4.sp,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        )
                      ])))
        ],
      ),
    );
  }
}
