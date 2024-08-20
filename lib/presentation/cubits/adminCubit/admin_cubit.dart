import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shophimikat/domain/repositories/admin_repository.dart';
import 'package:shophimikat/domain/repositories/products_repository.dart';
import 'package:shophimikat/domain/models/order_model.dart';
import 'package:shophimikat/domain/models/product_model.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/domain/repositories/promocode_repository.dart';

part 'admin_cubit.freezed.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final ProductsRepository _productsRepository = ProductsRepository();
  final AdminRepository _adminRepository = AdminRepository();
  final PromocodeRepository _promocodeRepository = PromocodeRepository();

  AdminCubit() : super(const Loading());

  Future<void> init() async {
    emit(const Intial());
  }

  Future<void> initState() async {
    Map result = await _adminRepository.getStats();
    emit(IntialStats(result['users'], result['orders']));
  }

  Future<void> addProduct(String article, String title, String price,
      XFile? image, String? category) async {
    print('CUBIT');
    String base64Image = base64Encode(await image!.readAsBytes());
    String fileName = image.name;
    print(base64Image);
    print(fileName);
    bool result = await _productsRepository.addProduct(
        article, title, price, base64Image, fileName, category ?? '');
    if (result) {
      emit(const Success());
    } else {
      emit(Error("Ошибка"));
    }
  }

  Future<void> deleteProduct(int article) async {
    emit(Loading());
    bool result = await _adminRepository.deleteProduct(article);
    if (result) {
      emit(const Success());
    } else {
      emit(const Error('Товар не найден'));
    }
  }

  Future<void> editProduct(
      String article,
      String title,
      String price,
      String? category,
      String photo,
      XFile? image,
      int salePrice,
      int sale) async {
    String base64Image =
        image != null ? base64Encode(await image!.readAsBytes()) : '';
    String fileName = image != null ? image.name : photo;

    emit(Loading());
    bool result = await _adminRepository.editProduct(article, title, price,
        category ?? '', base64Image, fileName, image == null, salePrice, sale);
    if (result) {
      emit(const Success());
    } else {
      emit(Error("Ошибка"));
    }
  }

  Future<void> addPromocode(String promocode, int skidka) async {
    bool result = await _promocodeRepository.addPromocode(promocode, skidka);
    if (result) {
      emit(const Success());
    } else {
      emit(Error("Ошибка"));
    }
  }

  Future<void> deletePromocode(int id) async {
    emit(Loading());
    bool result = await _adminRepository.deletePromocode(id);
    if (result) {
      emit(const Success());
    } else {
      emit(const Error('Промокод не найден'));
    }
  }

  Future<void> editPromocode(int id, String promocode, int skidka) async {
    emit(Loading());
    bool result = await _adminRepository.editPromocode(id, promocode, skidka);
    if (result) {
      emit(const Success());
    } else {
      emit(Error("Ошибка"));
    }
  }
}
