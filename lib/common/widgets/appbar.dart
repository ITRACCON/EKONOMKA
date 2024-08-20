import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/presentation/cubits/appBarCubit/appbar_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final bool back;
  final void Function() onTapBasket;
  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.back = false,
    required this.onTapBasket,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late AppBarCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AppBarCubit()..initialAppBar();
  }

  @override
  Widget build(BuildContext context) {
    cubit.initialAppBar();
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leading: Builder(builder: (context) {
        return widget.back
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22.sp),
              )
            : IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu_rounded, size: 22.sp),
              );
      }),
      title: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.home),
        child: SizedBox(
            width: 50.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.mobileLogo,
                  width: 7.w,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                    text: AppTexts.appName,
                    textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold))
              ],
            )),
      ),
      actions: [
        BlocBuilder<AppBarCubit, AppBarState>(
            bloc: cubit,
            builder: (context, state) {
              return state.when(
                  initial: (bool basketIsEmpty) => ActionsWidgets(
                        colorActionBasket: !basketIsEmpty
                            ? Colors.transparent
                            : AppColors.primary,
                        onTapBasket: () {
                          widget.onTapBasket();
                        },
                      ),
                  loading: () => ActionsWidgets(
                      colorActionBasket: Colors.blue, onTapBasket: () {}),
                  error: () => ActionsWidgets(
                      colorActionBasket: Colors.red, onTapBasket: () {}));
            })
      ],
    );
  }
}

class ActionsWidgets extends StatelessWidget {
  final void Function() onTapBasket;
  final Color colorActionBasket;

  const ActionsWidgets(
      {super.key, required this.onTapBasket, required this.colorActionBasket});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          onTapBasket();
        },
        child: Container(
            padding: EdgeInsets.only(right: 5.w, left: 2.w),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(Icons.shopping_bag_outlined, size: 18.sp),
                Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: colorActionBasket,
                        borderRadius: BorderRadius.circular(10)))
              ],
            )),
      )
    ]);
  }
}
