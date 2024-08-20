part of 'basket_cubit.dart';

@freezed
abstract class BasketState with _$BasketState {
  const factory BasketState.initial(List<BasketProduct> basketProducts) =
      Intial;

  const factory BasketState.loading() = Loading;
  const factory BasketState.success() = Success;

  const factory BasketState.error(String text) = Error;
}
