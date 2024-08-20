import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shophimikat/domain/models/promocode_model.dart';
import 'package:shophimikat/domain/repositories/promocode_repository.dart';

part 'promocode_cubit.freezed.dart';

part 'promocode_state.dart';

class PromocodeCubit extends Cubit<PromocodeState> {
  final PromocodeRepository _promocodeRepository = PromocodeRepository();

  PromocodeCubit() : super(const Loading());

  Future<void> init() async {
    emit(const Initial());
  }

  Future<void> checkPromo(
    String promocode,
  ) async {
    Map result = await _promocodeRepository.checkPromocode(promocode);
    if (result['result']) {
      emit(Success({'promo': promocode, 'skidka': result['skidka']}));
    } else {
      emit(const Error());
    }
  }

  Future<void> initPromocodes() async {
    Map result = await _promocodeRepository.getPromocodes();

    if (result['result']) {
      List<PromocodeModel> promocodes = result['promocodes'];

      emit(InitialPromocodes(
          promocodes, (promocodes.length / 30).round(), 'initPage'));
    } else {
      emit(const Error());
    }
  }

  Future<bool> initListPromocodes(int page, String typePage) async {
    Map result = await _promocodeRepository.getPromocodes();

    if (result['result']) {
      List<PromocodeModel> promocodes = result['promocodes'];

      if (page == 1) {
        List<PromocodeModel> pageList = promocodes.take(page * 30).toList();

        emit(InitialPromocodes(
            pageList, (pageList.length / 30).round(), typePage));
      } else {
        List<PromocodeModel> pageList =
            promocodes.skip((page - 1) * 30).take(30).toList();

        emit(InitialPromocodes(
            pageList, (pageList.length / 30).round(), typePage));
      }

      return true;
    } else {
      emit(const Error());
      return false;
    }
  }
}
