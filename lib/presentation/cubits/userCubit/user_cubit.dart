import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shophimikat/domain/dao/user_dao.dart';
import 'package:shophimikat/domain/repositories/user_repository.dart';
import 'package:shophimikat/domain/models/user_model.dart';

part 'user_cubit.freezed.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();

  UserCubit() : super(const Loading());

  Future<void> intialUser() async {
    emit(const Loading());

    Map result = await _userRepository.getUserWeb();
    if (result['result']) {
      UserModel user = result['user'];
      emit(Intial(user));
    } else {
      emit(const NoUser());
    }
  }

  Future<void> getIfoUser() async {
    emit(const Loading());

    Map result = await _userRepository.getInfoUser();
    Map resultUser = await _userRepository.getUserWeb();
    UserModel user = resultUser['user'];
    if (result['result']) {
      emit(IntialLk(result, user));
    } else {
      emit(const NoUser());
    }
  }

  Future<void> loginUser(String phone, String password) async {
    emit(const Loading());
    Map result = await _userRepository.loginUser(phone, password);
    try {
    if (result['result']) {
      if (result['resultLogin'] == 'SUCCESS') {
        UserModel userWeb = result['user'];
        await UserDao().createUserWeb(userWeb);
        emit(const Success('Успешная авторизация'));
      } else if (result['resultLogin'] == 'FAIL_PASS') {
        emit(const Error('Введенный праоль не подходит'));
      } else if (result['resultLogin'] == 'NO_USER') {
        emit(const Error('Ошибка автооизации, вы не зарегистрированны'));
      }
    } else {
      emit(const Error('Ошибка запроса'));
    }
    }
    catch (e) {
      print('Err');
      print(e);
    }
  }

  Future<void> updatePhone(String phone) async {
    Map resultUser = await _userRepository.getUserWeb();
    UserModel user = resultUser['user'];
    await _userRepository.updatePhone(phone, user.userId);
  }

  Future<void> updatePassword(String password) async {
    Map resultUser = await _userRepository.getUserWeb();
    UserModel user = resultUser['user'];
    await _userRepository.updatePassword(password, user.userId);
  }

  Future<void> logout() async {
    await _userRepository.logout();
  }

  Future<void> regUser(
      String phone, String password, String referalcode) async {
    emit(const Loading());
    Map result = await _userRepository.regUser(phone, password, referalcode);
    if (result['result']) {
      if (result['resultLogin'] == 'SUCCESS') {
        UserModel userWeb = result['user'];
        await UserDao().createUserWeb(userWeb);
        emit(const Success('Вы зарегистрированы'));
      } else if (result['resultLogin'] == 'PHONE_USE') {
        emit(const Error('Номер телефона уже используется'));
      }
    } else {
      emit(const Error('Ошибка запроса'));
    }
  }
}
