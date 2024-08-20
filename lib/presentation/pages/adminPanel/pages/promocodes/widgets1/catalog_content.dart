import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/presentation/cubits/adminCubit/admin_cubit.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/add_promocode_screen.dart';
import 'package:shophimikat/presentation/pages/adminPanel/pages/promocodes/widgets1/promocode_card.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/sidebar.dart';
import 'package:sizer/sizer.dart';

class PromocodesContent extends StatefulWidget {
  final List<PromocodeModel> promocodes;
  final int pages;
  final String typePage;
  final void Function(int page, String typePages) initPromocodes;
  const PromocodesContent(
      {super.key,
      required this.promocodes,
      required this.pages,
      required this.initPromocodes,
      required this.typePage});

  @override
  State<PromocodesContent> createState() => _PromocodesContentState();
}

class _PromocodesContentState extends State<PromocodesContent> {
  late ScrollController scrollController;
  late AdminCubit cubit;
  int page = 1;
  String typePage = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    cubit = AdminCubit();
    typePage = widget.typePage;
  }

  _scrollListener() {
    ScrollPosition position = scrollController.position;

    if (scrollController.offset >= position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (page < widget.pages) {
        setState(() {
          page += 1;
          typePage = 'nextPage';
        });
        widget.initPromocodes(
          page,
          'nextPage',
        );
      }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      if (page > 1) {
        setState(() {
          page -= 1;
          typePage = 'backPage';
        });
        widget.initPromocodes(page, 'backPage');
      }
    }
  }

  checkTypePage() {
    if (widget.typePage == 'nextPage' || widget.typePage == 'initPage') {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
            scrollController.position.minScrollExtent + 10,
            duration: const Duration(milliseconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    } else if (widget.typePage == 'initPage') {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
            scrollController.position.maxScrollExtent - 10,
            duration: const Duration(milliseconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    } else {}
  }

  @override
  void dispose() {
    scrollController.dispose();
    widget.promocodes.clear();
    super.dispose();
  }

  deletePromocode(int id) {
    cubit.deletePromocode(id);
  }

  @override
  Widget build(BuildContext context) {
    checkTypePage();
    return BlocListener<AdminCubit, AdminState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is Success) {
            QuickAlert.show(
                width: isMobile(context) ? 80.w : 25.w,
                context: context,
                type: QuickAlertType.success,
                title: 'Промокод успешно удален',
                confirmBtnText: AppTexts.close,
                confirmBtnColor: AppColors.primary,
                confirmBtnTextStyle: TextStyle(
                    fontSize: isMobile(context) ? 12.sp : 3.sp,
                    color: AppColors.white));
          } else if (state is Error) {
            QuickAlert.show(
                width: isMobile(context) ? 80.w : 25.w,
                context: context,
                type: QuickAlertType.error,
                title: state.error,
                confirmBtnText: AppTexts.close,
                confirmBtnColor: AppColors.primary,
                confirmBtnTextStyle: TextStyle(
                    fontSize: isMobile(context) ? 12.sp : 3.sp,
                    color: AppColors.white));
          }
        },
        child: isMobile(context)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  children: [
                    AppText(
                        text: "Промокоды",
                        textStyle: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddPromocodeScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          width: 90.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary),
                          child: AppText(
                              text: 'Создать промокод',
                              textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white)),
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    widget.promocodes.isEmpty
                        ? Column(
                            children: [
                              AppText(
                                  text: "Промокодов не",
                                  textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 2.h),
                              AppText(
                                  text:
                                      "К сожалению вы еще не создали промокод",
                                  textStyle: TextStyle(fontSize: 12.sp)),
                            ],
                          )
                        : Expanded(
                            child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 88.w,
                                child: ListView(
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  children: [
                                    Wrap(
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: widget.promocodes
                                          .map((promocode) =>
                                              PromocodeCardAdmin(
                                                deletePromocode: (int article) {
                                                  deletePromocode(article);
                                                  widget.initPromocodes(
                                                      1, 'initPage');
                                                },
                                                promocode: promocode,
                                                key: ValueKey(promocode.id),
                                              ))
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: widget.pages,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: InkWell(
                                              onTap: () {
                                                widget.initPromocodes(
                                                    index + 1, 'initPage');
                                                setState(() {
                                                  page = index + 1;
                                                });
                                              },
                                              child: AppText(
                                                text: (index + 1).toString(),
                                                textStyle: TextStyle(
                                                    fontSize: page == index + 1
                                                        ? 16.sp
                                                        : 12.sp,
                                                    color: page == index + 1
                                                        ? AppColors.primary
                                                        : AppColors.black
                                                            .withOpacity(0.2),
                                                    fontWeight: page ==
                                                            index + 1
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                            ),
                                          )))
                            ],
                          ))
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const SidebarDesctop(routName: ''),
                    Container(
                      width: 70.w,
                      height: 82.h,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.promocodes.isEmpty
                              ? SizedBox(
                                  width: 75.w,
                                  height: 71.h,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 2.h),
                                      AppText(
                                          text: "Пустые полки",
                                          textStyle: TextStyle(
                                              fontSize: 4.sp,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 2.h),
                                      AppText(
                                          text:
                                              "К сожалению в данной категории товаров пока нет.",
                                          textStyle: TextStyle(fontSize: 3.sp)),
                                    ],
                                  ))
                              : Expanded(
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 75.w,
                                      height: 71.h,
                                      child: ListView(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        children: [
                                          Wrap(
                                            spacing: 4,
                                            runSpacing: 4,
                                            children: widget.promocodes
                                                .map((promocode) =>
                                                    PromocodeCardAdmin(
                                                      deletePromocode:
                                                          (int article) {
                                                        deletePromocode(
                                                            article);
                                                        widget.initPromocodes(
                                                            1, 'initPage');
                                                      },
                                                      promocode: promocode,
                                                      key: ValueKey(
                                                          promocode.id),
                                                    ))
                                                .toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: widget.pages,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 7),
                                                  child: InkWell(
                                                    onTap: () {
                                                      widget.initPromocodes(
                                                          index + 1,
                                                          'initPage');
                                                      setState(() {
                                                        page = index + 1;
                                                      });
                                                    },
                                                    child: AppText(
                                                      text: (index + 1)
                                                          .toString(),
                                                      textStyle: TextStyle(
                                                          fontSize:
                                                              page == index + 1
                                                                  ? 3.sp
                                                                  : 3.sp,
                                                          color: page ==
                                                                  index + 1
                                                              ? AppColors
                                                                  .primary
                                                              : AppColors.black
                                                                  .withOpacity(
                                                                      0.2),
                                                          fontWeight: page ==
                                                                  index + 1
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal),
                                                    ),
                                                  ),
                                                )))
                                  ],
                                ))
                        ],
                      ),
                    )
                  ]));
  }
}

class CatalogEmptyContent extends StatelessWidget {
  final String category;
  const CatalogEmptyContent({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        height: 85.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
                text: category,
                textStyle:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                SizedBox(height: 2.h),
                AppText(
                    text: "Пустые полки",
                    textStyle: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 2.h),
                AppText(
                    text: "К сожалению в данной категории товаров пока нет.",
                    textStyle: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
