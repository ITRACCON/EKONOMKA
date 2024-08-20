part of 'appbar_cubit.dart';

@freezed
abstract class AppBarState with _$AppBarState {
  const factory AppBarState.initial(bool basketIsEmpty) =  Intial;

  const factory AppBarState.loading() = Loading;

  const factory AppBarState.error() = Error;
}
