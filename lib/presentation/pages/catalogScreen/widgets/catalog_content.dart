import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/presentation/cubits/basketCubit/basket_cubit.dart';
import 'package:shophimikat/presentation/pages/catalogScreen/widgets/product_card.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/sidebar.dart';
import 'package:sizer/sizer.dart';

class CatalogContent extends StatefulWidget {
  final List<Map> products;
  final String category;
  final String categoryCode;
  final int pages;
  final void Function(int minPrice, int maxPrice, String valueSort, int page,
      String typePage, String searchReq) initCatalog;
  final String typePage;
  const CatalogContent(
      {super.key,
      required this.products,
      required this.category,
      required this.initCatalog,
      required this.pages,
      required this.typePage,
      required this.categoryCode});

  @override
  State<CatalogContent> createState() => _CatalogContentState();
}

class _CatalogContentState extends State<CatalogContent> {
  List<String> items = ['Новинки', 'Сначала дешевле', 'Сначала дороже'];
  String? selectedValue;
  late ScrollController scrollController;
  RangeValues _currentRangeValues = const RangeValues(0, 1000);
  int page = 1;

  bool blocSearch = false;
  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String searchReq = 'NO';
  String typePage = 'initPage';

  late BasketCubit basketCubit;
  @override
  void initState() {
    super.initState();
    selectedValue = 'Новинки';
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    basketCubit = BasketCubit();
  }

  searchProduct(value) {
    if (value.length > 4) {
      widget.initCatalog(
          _currentRangeValues.start.toInt(),
          _currentRangeValues.end.toInt(),
          selectedValue!,
          1,
          'initPage',
          value);
      setState(() {
        page = 1;
        searchReq = value;
      });
    } else if (value.length == 0) {
      widget.initCatalog(_currentRangeValues.start.toInt(),
          _currentRangeValues.end.toInt(), selectedValue!, 1, 'initPage', 'NO');
      setState(() {
        searchReq = 'NO';
        page = 1;
      });
    }
  }

  sortCatalog(value) {
    if (value == 'Новинки') {
      widget.initCatalog(_currentRangeValues.start.toInt(),
          _currentRangeValues.end.toInt(), value, page, 'initPage', searchReq);
      setState(() {
        selectedValue = value;
        page = 1;
      });
    } else if (value == 'Сначала дешевле') {
      widget.initCatalog(_currentRangeValues.start.toInt(),
          _currentRangeValues.end.toInt(), value, page, 'initPage', searchReq);
      setState(() {
        selectedValue = value;
        page = 1;
      });
    } else if (value == 'Сначала дороже') {
      widget.initCatalog(_currentRangeValues.start.toInt(),
          _currentRangeValues.end.toInt(), value, page, 'initPage', searchReq);
      setState(() {
        selectedValue = value;
        page = 1;
      });
    }
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
        widget.initCatalog(
            _currentRangeValues.start.toInt(),
            _currentRangeValues.end.toInt(),
            selectedValue!,
            page,
            'nextPage',
            searchReq);
      }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      if (page > 1) {
        setState(() {
          page -= 1;
          typePage = 'backPage';
        });
        widget.initCatalog(
            _currentRangeValues.start.toInt(),
            _currentRangeValues.end.toInt(),
            selectedValue!,
            page,
            'backPage',
            searchReq);
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

  buyProduct(int article) {
    basketCubit.addProductBasket(article, 1, 'catalog');

    widget.initCatalog(
        _currentRangeValues.start.toInt(),
        _currentRangeValues.end.toInt(),
        selectedValue!,
        page,
        'buyProduct',
        searchReq);
  }

  addCountProduct(int article) {
    basketCubit.addAmountBasketProduct(article, 1, 'catalog');
    widget.initCatalog(
        _currentRangeValues.start.toInt(),
        _currentRangeValues.end.toInt(),
        selectedValue!,
        page,
        'buyProduct',
        searchReq);
  }

  minusCountsProduct(int article) {
    basketCubit.minusAmountBasketProduct(article, 1, 'catalog');
    widget.initCatalog(
        _currentRangeValues.start.toInt(),
        _currentRangeValues.end.toInt(),
        selectedValue!,
        page,
        'buyProduct',
        searchReq);
  }

  remuveProductBasket(int article) {
    basketCubit.remuveProductBasket(article, 'catalog');
    widget.initCatalog(
        _currentRangeValues.start.toInt(),
        _currentRangeValues.end.toInt(),
        selectedValue!,
        page,
        'buyProduct',
        searchReq);
  }

  @override
  void dispose() {
    scrollController.dispose();
    widget.products.clear();
    _searchController.dispose();
    super.dispose();
  }

  showModalBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            height: 27.h,
            padding: EdgeInsets.symmetric(vertical: 1.h),
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    AppText(
                        text: 'Фильтры',
                        textStyle: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Divider(
                      height: 2,
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 1.h),
                        width: 90.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                                text:
                                    "Цена: ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}",
                                textStyle: TextStyle(fontSize: 14.sp)),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                    text: '1',
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold)),
                                AppText(
                                    text: '1000',
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            SliderTheme(
                                data: SliderThemeData(
                                    // here
                                    overlayShape:
                                        SliderComponentShape.noOverlay,
                                    trackHeight: 1.5.h),
                                child: RangeSlider(
                                  activeColor: AppColors.primary,
                                  inactiveColor: AppColors.textSecondary,
                                  values: _currentRangeValues,
                                  max: 1000,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    _currentRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    state(() {
                                      _currentRangeValues = values;
                                    });
                                  },
                                ))
                          ],
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                        onTap: () {
                          widget.initCatalog(
                              _currentRangeValues.start.toInt(),
                              _currentRangeValues.end.toInt(),
                              selectedValue!,
                              1,
                              'initPage',
                              searchReq);
                          state(() {
                            page = 1;
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primary),
                          child: AppText(
                              text: 'Применить',
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white)),
                        )),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkTypePage();
    return BlocListener<BasketCubit, BasketState>(
        bloc: basketCubit,
        listener: (context, state) {
          if (state is Success) {
          } else if (state is Error) {
            QuickAlert.show(
                width: isMobile(context) ? 80.w : 25.w,
                context: context,
                type: QuickAlertType.error,
                title: state.text,
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
                        text: widget.category,
                        textStyle: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 89.w,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            blocSearch
                                ? SizedBox(
                                    width: 65.w,
                                    child: Form(
                                        key: _formKey,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: AppColors.inputPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2)),
                                          child: TextFormField(
                                            maxLines: 1,
                                            maxLength: 50,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12),
                                              fillColor: Colors.grey,
                                              hintText: 'Жидкое мыло',
                                              counterText: '',
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isMobile(context)
                                                      ? 12.sp
                                                      : 3.sp),
                                            ),
                                            controller: _searchController,
                                            onChanged: (value) =>
                                                searchProduct(value),
                                          ),
                                        )))
                                : Container(
                                    width: 48.w,
                                    alignment: Alignment.centerLeft,
                                    child: DropdownFlutter(
                                      closedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                      listItemPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                      itemsListPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                      expandedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                      decoration: CustomDropdownDecoration(
                                          closedBorderRadius:
                                              BorderRadius.circular(5)),
                                      items: items,
                                      initialItem: items.first,
                                      onChanged: (value) {
                                        sortCatalog(value);
                                      },
                                    )),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  blocSearch
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              page = 1;
                                              blocSearch = false;
                                              _searchController.clear();
                                              searchReq = 'NO';
                                              widget.initCatalog(
                                                  _currentRangeValues.start
                                                      .toInt(),
                                                  _currentRangeValues.end
                                                      .toInt(),
                                                  selectedValue!,
                                                  1,
                                                  'initPage',
                                                  'NO');
                                            });
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: AppColors.white),
                                              child: Icon(
                                                Icons.close,
                                                size: 23.sp,
                                                color: AppColors.black,
                                                weight: 5,
                                              )))
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              blocSearch = true;
                                            });
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: AppColors.white),
                                              child: Icon(
                                                Icons.search,
                                                size: 23.sp,
                                                color: AppColors.black,
                                                weight: 5,
                                              ))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showModalBottom();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  width: 3,
                                                  color: AppColors.primary)),
                                          child: Icon(
                                            Icons.tune,
                                            size: 18.sp,
                                            color: AppColors.primary,
                                            weight: 5,
                                          )))
                                ])
                          ]),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    widget.products.isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 2.h),
                              AppText(
                                  text: "Пустые полки",
                                  textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 2.h),
                              AppText(
                                  text:
                                      "К сожалению в данной категории товаров пока нет.",
                                  textStyle: TextStyle(fontSize: 12.sp)),
                            ],
                          )
                        : Expanded(
                            child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 86.w,
                                child: ListView(
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  children: [
                                    Wrap(
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: widget.products
                                          .map((product) => ProductCard(
                                                searchText: searchReq,
                                                buyProduct: (int article) =>
                                                    buyProduct(article),
                                                addCountProduct: (int
                                                        article) =>
                                                    addCountProduct(article),
                                                minusCountsProduct: (int
                                                        article) =>
                                                    minusCountsProduct(article),
                                                remuveProductBasket:
                                                    (int article) =>
                                                        remuveProductBasket(
                                                            article),
                                                product: product['product'],
                                                key: ValueKey(
                                                    product['product'].article),
                                                isBasket: product['buy'],
                                                count: product['buy']
                                                    ? product['basketProduct']
                                                        .amount
                                                    : 0,
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
                                                widget.initCatalog(
                                                    _currentRangeValues.start
                                                        .toInt(),
                                                    _currentRangeValues.end
                                                        .toInt(),
                                                    selectedValue!,
                                                    index + 1,
                                                    'initPage',
                                                    searchReq);
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
                    Column(
                      children: [
                        SidebarDesctop(routName: widget.categoryCode),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: 27.h,
                          width: 18.w,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: [
                                  AppText(
                                      text: 'Фильтры',
                                      textStyle: TextStyle(
                                          fontSize: 3.sp,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  const Divider(
                                    height: 2,
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 1.h),
                                      width: 16.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppText(
                                              text:
                                                  "Цена: ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}",
                                              textStyle:
                                                  TextStyle(fontSize: 3.sp)),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                  text: '1',
                                                  textStyle: TextStyle(
                                                      fontSize: 3.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              AppText(
                                                  text: '1000',
                                                  textStyle: TextStyle(
                                                      fontSize: 3.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          SliderTheme(
                                              data: SliderThemeData(
                                                  // here
                                                  overlayShape:
                                                      SliderComponentShape
                                                          .noOverlay,
                                                  trackHeight: 1.5.h),
                                              child: RangeSlider(
                                                activeColor: AppColors.primary,
                                                inactiveColor:
                                                    AppColors.textSecondary,
                                                values: _currentRangeValues,
                                                max: 1000,
                                                divisions: 100,
                                                labels: RangeLabels(
                                                  _currentRangeValues.start
                                                      .round()
                                                      .toString(),
                                                  _currentRangeValues.end
                                                      .round()
                                                      .toString(),
                                                ),
                                                onChanged:
                                                    (RangeValues values) {
                                                  setState(() {
                                                    _currentRangeValues =
                                                        values;
                                                  });
                                                },
                                              ))
                                        ],
                                      )),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        widget.initCatalog(
                                            _currentRangeValues.start.toInt(),
                                            _currentRangeValues.end.toInt(),
                                            selectedValue!,
                                            1,
                                            'initPage',
                                            searchReq);
                                        setState(() {
                                          page = 1;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.primary),
                                        child: AppText(
                                            text: 'Применить',
                                            textStyle: TextStyle(
                                                fontSize: 3.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white)),
                                      )),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 70.w,
                      height: 82.h,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.w,
                                child: Form(
                                    key: _formKey,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.inputPrimary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: TextFormField(
                                        maxLines: 1,
                                        maxLength: 50,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 12),
                                          fillColor: Colors.grey,
                                          hintText: 'Жидкое мыло',
                                          counterText: '',
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Color(0xff999999),
                                              fontWeight: FontWeight.w400,
                                              fontSize: isMobile(context)
                                                  ? 12.sp
                                                  : 3.sp),
                                        ),
                                        controller: _searchController,
                                        onChanged: (value) =>
                                            searchProduct(value),
                                      ),
                                    )),
                              ),
                              Container(
                                  width: 15.w,
                                  alignment: Alignment.centerLeft,
                                  child: DropdownFlutter(
                                    closedHeaderPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                    listItemPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    itemsListPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                    expandedHeaderPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                    decoration: CustomDropdownDecoration(
                                        closedBorderRadius:
                                            BorderRadius.circular(5)),
                                    items: items,
                                    initialItem: items.first,
                                    onChanged: (value) {
                                      sortCatalog(value);
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          widget.products.isEmpty
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
                                            children: widget.products
                                                .map((product) => ProductCard(
                                                      searchText: searchReq,
                                                      buyProduct: (int
                                                              article) =>
                                                          buyProduct(article),
                                                      addCountProduct:
                                                          (int article) =>
                                                              addCountProduct(
                                                                  article),
                                                      minusCountsProduct: (int
                                                              article) =>
                                                          minusCountsProduct(
                                                              article),
                                                      remuveProductBasket: (int
                                                              article) =>
                                                          remuveProductBasket(
                                                              article),
                                                      product:
                                                          product['product'],
                                                      key: ValueKey(
                                                          product['product']
                                                              .article),
                                                      isBasket: product['buy'],
                                                      count: product['buy']
                                                          ? product[
                                                                  'basketProduct']
                                                              .amount
                                                          : 0,
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
                                                      widget.initCatalog(
                                                          _currentRangeValues
                                                              .start
                                                              .toInt(),
                                                          _currentRangeValues
                                                              .end
                                                              .toInt(),
                                                          selectedValue!,
                                                          index + 1,
                                                          'initPage',
                                                          searchReq);
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
