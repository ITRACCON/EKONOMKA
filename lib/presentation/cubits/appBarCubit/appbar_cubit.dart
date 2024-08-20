import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shophimikat/data/local/local_storage.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/repositories/basket_repository.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
part 'appbar_cubit.freezed.dart';

part 'appbar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  final BasketRepository _basketRepository = BasketRepository();

  AppBarCubit() : super(const Loading());

  Future<bool> initialAppBar() async {
    final WebAppInitData webAppInitData = tg.initDataUnsafe;
    emit(const Loading());

    final user = webAppInitData.hash == null
        ? await UserDao().getUser()
        : await UserTgProvider.getUser();
    Map result =
        await _basketRepository.isEmpty(user == null ? 0 : user.userId);
    if (result['result']) {
      bool basketIsEmpty = result['basketIsEmpty'];
      emit(Intial(basketIsEmpty));
      return true;
    } else {
      emit(const Error());
      return false;
    }
  }
}
