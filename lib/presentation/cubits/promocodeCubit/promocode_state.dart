part of 'promocode_cubit.dart';

@freezed
abstract class PromocodeState with _$PromocodeState {
  const factory PromocodeState.success(Map result) = Success;

  const factory PromocodeState.init() = Initial;

  const factory PromocodeState.initPromocodes(
          List<PromocodeModel> promocodes, int page, String typePage) =
      InitialPromocodes;

  const factory PromocodeState.loading() = Loading;

  const factory PromocodeState.error() = Error;
}
