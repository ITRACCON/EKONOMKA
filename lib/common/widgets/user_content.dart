import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class UserContent extends StatefulWidget {
  const UserContent({super.key});

  @override
  State<UserContent> createState() => _UserContentWebState();
}

class _UserContentWebState extends State<UserContent> {
  late UserCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = UserCubit()..intialUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: cubit,
      builder: (context, state) {
        (state);
        return state.when(
            initial: (UserModel user) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: user.typeAcc == 'web'
                                ? user.phone
                                : user.userTgFl,
                            textStyle: TextStyle(
                                fontSize: isMobile(context) ? 15.sp : 4.sp,
                                fontWeight: FontWeight.bold)),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            user.admin == 1
                                ? InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.admin),
                                    child: AppText(
                                        text: 'Админ панель',
                                        textStyle: TextStyle(
                                            fontSize: isMobile(context)
                                                ? 10.sp
                                                : 3.sp,
                                            color: AppColors.textSecondary)),
                                  )
                                : Container(),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.profile),
                              child: AppText(
                                  text: 'Личный кабинет',
                                  textStyle: TextStyle(
                                      fontSize:
                                          isMobile(context) ? 10.sp : 3.sp,
                                      color: AppColors.textSecondary)),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.basket),
                                child: AppText(
                                    text: 'Корзина',
                                    textStyle: TextStyle(
                                        fontSize:
                                            isMobile(context) ? 10.sp : 3.sp,
                                        color: AppColors.textSecondary))),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    user.typeAcc == 'web'
                        ? InkWell(
                            onTap: () {
                              cubit.logout();
                              Navigator.pushNamed(context, AppRoutes.home);
                            },
                            child: Icon(
                              Icons.exit_to_app_rounded,
                              color: AppColors.textRed,
                              size: isMobile(context) ? 20.sp : 7.sp,
                            ),
                          )
                        : Container()
                  ],
                ),
            loading: () => const CircularProgressIndicator(),
            noUser: () => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signin);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.buttonPrimary,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.2.h),
                    child: AppText(
                        text: 'Войти',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile(context) ? 15.sp : 4.sp,
                        )),
                  ),
                ),
            error: (text) => Container(),
            success: (String text) => Container(),
            initialLk: (Map<dynamic, dynamic> lk, UserModel user) =>
                Container());
      },
    );
  }
}
