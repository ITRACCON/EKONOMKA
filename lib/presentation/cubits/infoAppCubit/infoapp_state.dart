part of 'infoapp_cubit.dart';

@freezed
abstract class InfoAppState with _$InfoAppState {
  const factory InfoAppState.initial(InfoApp infoApp) = Intial;

  const factory InfoAppState.initialhome(Map home) = IntialHome;
  const factory InfoAppState.success() = Success;

  const factory InfoAppState.loading() = Loading;

  const factory InfoAppState.error(String error) = Error;
}
