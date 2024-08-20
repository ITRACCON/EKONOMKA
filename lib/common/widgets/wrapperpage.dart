import 'package:flutter/material.dart';
import 'package:shophimikat/common/widgets/user_content.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/images.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/appbar.dart';
import 'package:shophimikat/common/widgets/sidebar.dart';
import 'package:sizer/sizer.dart';

class Wrapperpage extends StatelessWidget {
  final String routName;
  final Widget content;
  final void Function() onTapBasket;
  final bool offLeftMenu;
  final bool offHeader;
  final bool backPage;
  final bool resizeToAvoidBottomInset;
  const Wrapperpage(
      {super.key,
      required this.routName,
      required this.content,
      required this.onTapBasket,
      this.offLeftMenu = false,
      this.offHeader = false,
      this.backPage = false,
      this.resizeToAvoidBottomInset = false});

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                backgroundColor: AppColors.light,
                appBar: CustomAppBar(
                  back: backPage,
                  onTapBasket: () {
                    onTapBasket();
                  },
                ),
                drawer: Sidebar(
                  routName: routName,
                ),
                body: content))
        : Scaffold(
            backgroundColor: AppColors.light,
            body: Container(
                width: 100.w,
                height: 100.h,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !offHeader
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.desktopLogo, width: 5.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const UserContent(),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 4.h,
                    ),
                    offLeftMenu
                        ? content
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SidebarDesctop(routName: routName),
                              content
                            ],
                          ),
                  ],
                )));
  }
}
