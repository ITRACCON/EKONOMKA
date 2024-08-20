import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/presentation/cubits/adminCubit/admin_cubit.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:shophimikat/common/widgets/input.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/constants/categorys.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/constants/texts.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenScreenState();
}

class _EditProductScreenScreenState extends State<EditProductScreen> {
  late AdminCubit cubit;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();

  String? category;

  XFile? image;

  bool sale = false;

  final _formKey = GlobalKey<FormState>();
  Color backgroundColor = Color(0xFFf5f5f5);
  Color borderColor = Color(0xFFf5f5f5);
  @override
  void initState() {
    super.initState();
    cubit = AdminCubit();
    _articleController.text = widget.product.article.toString();
    _priceController.text = widget.product.price.toString();
    _titleController.text = widget.product.title;
    _salePriceController.text = widget.product.salePrice.toString();
    category = widget.product.category;
    sale = widget.product.sale == 1 ? true : false;
  }

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
            child: BlocListener<AdminCubit, AdminState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is Success) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: AppTexts.successEditProduct,
                        confirmBtnText: AppTexts.okay,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  } else if (state is Error) {
                    context.loaderOverlay.hide();
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: AppTexts.errorEditProduct,
                        confirmBtnText: AppTexts.close,
                        confirmBtnColor: AppColors.primary,
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 12.sp, color: AppColors.white));
                  } else if (state is Loading) {
                    context.loaderOverlay.show();
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
                                                    Wrap(
                                                        spacing: 7,
                                                        runSpacing: 7,
                                                        children: AppInfo
                                                            .categorys
                                                            .map((categor) {
                                                          return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  category =
                                                                      categor[
                                                                          'key'];
                                                                });
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .primary,
                                                                        width:
                                                                            2),
                                                                    color: category ==
                                                                            categor[
                                                                                'key']
                                                                        ? AppColors
                                                                            .primary
                                                                        : AppColors
                                                                            .white),
                                                                child: AppText(
                                                                    text: categor[
                                                                        'title'],
                                                                    textStyle: TextStyle(
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: category ==
                                                                                categor['key']
                                                                            ? AppColors.white
                                                                            : AppColors.primary)),
                                                              ));
                                                        }).toList()),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Input(
                                                      readOnly: true,
                                                      title: AppTexts.article,
                                                      bgTextFormField:
                                                          backgroundColor,
                                                      border: borderColor,
                                                      controller:
                                                          _articleController,
                                                      maxLength: 10,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: () {},
                                                    ),
                                                    Input(
                                                      title:
                                                          AppTexts.titleProduct,
                                                      bgTextFormField:
                                                          backgroundColor,
                                                      border: borderColor,
                                                      controller:
                                                          _titleController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: () {},
                                                    ),
                                                    Input(
                                                      title:
                                                          AppTexts.priceProduct,
                                                      bgTextFormField:
                                                          backgroundColor,
                                                      border: borderColor,
                                                      controller:
                                                          _priceController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: () {},
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
                                                            width: 25.w,
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: CachedNetworkImage(
                                                                    imageUrl: image !=
                                                                            null
                                                                        ? image!
                                                                            .path
                                                                        : widget
                                                                            .product
                                                                            .photo))),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        InkWell(
                                                            onTap: () async {
                                                              XFile? image_old =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              setState(() {
                                                                image =
                                                                    image_old;
                                                              });
                                                            },
                                                            child: AppText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text:
                                                                  'Заменить изображение',
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: AppColors
                                                                      .primary),
                                                            )),
                                                      ],
                                                    ),
                                                    CheckboxListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: AppText(
                                                          textAlign:
                                                              TextAlign.left,
                                                          text:
                                                              'Акционный товар',
                                                          textStyle: TextStyle(
                                                              fontSize: 11.sp),
                                                        ),
                                                        activeColor:
                                                            AppColors.primary,
                                                        value: sale,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            sale = value!;
                                                          });
                                                        }),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    sale
                                                        ? Input(
                                                            title:
                                                                'Скидочная цена',
                                                            bgTextFormField:
                                                                backgroundColor,
                                                            border: borderColor,
                                                            controller:
                                                                _salePriceController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged: () {},
                                                          )
                                                        : Container(),
                                                  ],
                                                ))),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            if (_articleController
                                                    .text.isEmpty ||
                                                _titleController.text.isEmpty ||
                                                _priceController.text.isEmpty ||
                                                _salePriceController
                                                    .text.isEmpty ||
                                                category == null) {
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
                                              cubit.editProduct(
                                                  _articleController.text,
                                                  _titleController.text,
                                                  _priceController.text,
                                                  category,
                                                  widget.product.photo,
                                                  image,
                                                  int.parse(_salePriceController
                                                      .text),
                                                  sale ? 1 : 0);
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
                                                text: AppTexts.editProduct,
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
