part of 'user_cubit.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial(UserModel user) = Intial;
  const factory UserState.initialLk(Map lk, UserModel user) = IntialLk;

  const factory UserState.loading() = Loading;
  const factory UserState.success(String text) = Success;
  const factory UserState.noUser() = NoUser;
  const factory UserState.error(String text) = Error;
}
