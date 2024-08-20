// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promocode_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PromocodeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromocodeStateCopyWith<$Res> {
  factory $PromocodeStateCopyWith(
          PromocodeState value, $Res Function(PromocodeState) then) =
      _$PromocodeStateCopyWithImpl<$Res, PromocodeState>;
}

/// @nodoc
class _$PromocodeStateCopyWithImpl<$Res, $Val extends PromocodeState>
    implements $PromocodeStateCopyWith<$Res> {
  _$PromocodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<dynamic, dynamic> result});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$PromocodeStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
  }) {
    return _then(_$SuccessImpl(
      null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements Success {
  const _$SuccessImpl(final Map<dynamic, dynamic> result) : _result = result;

  final Map<dynamic, dynamic> _result;
  @override
  Map<dynamic, dynamic> get result {
    if (_result is EqualUnmodifiableMapView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_result);
  }

  @override
  String toString() {
    return 'PromocodeState.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return success(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return success?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements PromocodeState {
  const factory Success(final Map<dynamic, dynamic> result) = _$SuccessImpl;

  Map<dynamic, dynamic> get result;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PromocodeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PromocodeState.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class Initial implements PromocodeState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$InitialPromocodesImplCopyWith<$Res> {
  factory _$$InitialPromocodesImplCopyWith(_$InitialPromocodesImpl value,
          $Res Function(_$InitialPromocodesImpl) then) =
      __$$InitialPromocodesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PromocodeModel> promocodes, int page, String typePage});
}

/// @nodoc
class __$$InitialPromocodesImplCopyWithImpl<$Res>
    extends _$PromocodeStateCopyWithImpl<$Res, _$InitialPromocodesImpl>
    implements _$$InitialPromocodesImplCopyWith<$Res> {
  __$$InitialPromocodesImplCopyWithImpl(_$InitialPromocodesImpl _value,
      $Res Function(_$InitialPromocodesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promocodes = null,
    Object? page = null,
    Object? typePage = null,
  }) {
    return _then(_$InitialPromocodesImpl(
      null == promocodes
          ? _value._promocodes
          : promocodes // ignore: cast_nullable_to_non_nullable
              as List<PromocodeModel>,
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      null == typePage
          ? _value.typePage
          : typePage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitialPromocodesImpl implements InitialPromocodes {
  const _$InitialPromocodesImpl(
      final List<PromocodeModel> promocodes, this.page, this.typePage)
      : _promocodes = promocodes;

  final List<PromocodeModel> _promocodes;
  @override
  List<PromocodeModel> get promocodes {
    if (_promocodes is EqualUnmodifiableListView) return _promocodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promocodes);
  }

  @override
  final int page;
  @override
  final String typePage;

  @override
  String toString() {
    return 'PromocodeState.initPromocodes(promocodes: $promocodes, page: $page, typePage: $typePage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialPromocodesImpl &&
            const DeepCollectionEquality()
                .equals(other._promocodes, _promocodes) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.typePage, typePage) ||
                other.typePage == typePage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_promocodes), page, typePage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialPromocodesImplCopyWith<_$InitialPromocodesImpl> get copyWith =>
      __$$InitialPromocodesImplCopyWithImpl<_$InitialPromocodesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return initPromocodes(promocodes, page, typePage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return initPromocodes?.call(promocodes, page, typePage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (initPromocodes != null) {
      return initPromocodes(promocodes, page, typePage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return initPromocodes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return initPromocodes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initPromocodes != null) {
      return initPromocodes(this);
    }
    return orElse();
  }
}

abstract class InitialPromocodes implements PromocodeState {
  const factory InitialPromocodes(final List<PromocodeModel> promocodes,
      final int page, final String typePage) = _$InitialPromocodesImpl;

  List<PromocodeModel> get promocodes;
  int get page;
  String get typePage;
  @JsonKey(ignore: true)
  _$$InitialPromocodesImplCopyWith<_$InitialPromocodesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PromocodeStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PromocodeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements PromocodeState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$PromocodeStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl();

  @override
  String toString() {
    return 'PromocodeState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<dynamic, dynamic> result) success,
    required TResult Function() init,
    required TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)
        initPromocodes,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<dynamic, dynamic> result)? success,
    TResult? Function()? init,
    TResult? Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<dynamic, dynamic> result)? success,
    TResult Function()? init,
    TResult Function(
            List<PromocodeModel> promocodes, int page, String typePage)?
        initPromocodes,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success value) success,
    required TResult Function(Initial value) init,
    required TResult Function(InitialPromocodes value) initPromocodes,
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success value)? success,
    TResult? Function(Initial value)? init,
    TResult? Function(InitialPromocodes value)? initPromocodes,
    TResult? Function(Loading value)? loading,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success value)? success,
    TResult Function(Initial value)? init,
    TResult Function(InitialPromocodes value)? initPromocodes,
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements PromocodeState {
  const factory Error() = _$ErrorImpl;
}
