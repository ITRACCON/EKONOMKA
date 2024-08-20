// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IntialImplCopyWith<$Res> {
  factory _$$IntialImplCopyWith(
          _$IntialImpl value, $Res Function(_$IntialImpl) then) =
      __$$IntialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});
}

/// @nodoc
class __$$IntialImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$IntialImpl>
    implements _$$IntialImplCopyWith<$Res> {
  __$$IntialImplCopyWithImpl(
      _$IntialImpl _value, $Res Function(_$IntialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$IntialImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$IntialImpl implements Intial {
  const _$IntialImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserState.initial(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntialImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntialImplCopyWith<_$IntialImpl> get copyWith =>
      __$$IntialImplCopyWithImpl<_$IntialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return initial(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return initial?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Intial implements UserState {
  const factory Intial(final UserModel user) = _$IntialImpl;

  UserModel get user;
  @JsonKey(ignore: true)
  _$$IntialImplCopyWith<_$IntialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntialLkImplCopyWith<$Res> {
  factory _$$IntialLkImplCopyWith(
          _$IntialLkImpl value, $Res Function(_$IntialLkImpl) then) =
      __$$IntialLkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<dynamic, dynamic> lk, UserModel user});
}

/// @nodoc
class __$$IntialLkImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$IntialLkImpl>
    implements _$$IntialLkImplCopyWith<$Res> {
  __$$IntialLkImplCopyWithImpl(
      _$IntialLkImpl _value, $Res Function(_$IntialLkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lk = null,
    Object? user = null,
  }) {
    return _then(_$IntialLkImpl(
      null == lk
          ? _value._lk
          : lk // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$IntialLkImpl implements IntialLk {
  const _$IntialLkImpl(final Map<dynamic, dynamic> lk, this.user) : _lk = lk;

  final Map<dynamic, dynamic> _lk;
  @override
  Map<dynamic, dynamic> get lk {
    if (_lk is EqualUnmodifiableMapView) return _lk;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lk);
  }

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserState.initialLk(lk: $lk, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntialLkImpl &&
            const DeepCollectionEquality().equals(other._lk, _lk) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lk), user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntialLkImplCopyWith<_$IntialLkImpl> get copyWith =>
      __$$IntialLkImplCopyWithImpl<_$IntialLkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return initialLk(lk, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return initialLk?.call(lk, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) {
    if (initialLk != null) {
      return initialLk(lk, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return initialLk(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return initialLk?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initialLk != null) {
      return initialLk(this);
    }
    return orElse();
  }
}

abstract class IntialLk implements UserState {
  const factory IntialLk(final Map<dynamic, dynamic> lk, final UserModel user) =
      _$IntialLkImpl;

  Map<dynamic, dynamic> get lk;
  UserModel get user;
  @JsonKey(ignore: true)
  _$$IntialLkImplCopyWith<_$IntialLkImpl> get copyWith =>
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
    extends _$UserStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'UserState.loading()';
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
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
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
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements UserState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$SuccessImpl(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements Success {
  const _$SuccessImpl(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'UserState.success(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return success(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return success?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements UserState {
  const factory Success(final String text) = _$SuccessImpl;

  String get text;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoUserImplCopyWith<$Res> {
  factory _$$NoUserImplCopyWith(
          _$NoUserImpl value, $Res Function(_$NoUserImpl) then) =
      __$$NoUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoUserImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$NoUserImpl>
    implements _$$NoUserImplCopyWith<$Res> {
  __$$NoUserImplCopyWithImpl(
      _$NoUserImpl _value, $Res Function(_$NoUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NoUserImpl implements NoUser {
  const _$NoUserImpl();

  @override
  String toString() {
    return 'UserState.noUser()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return noUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return noUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) {
    if (noUser != null) {
      return noUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return noUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return noUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (noUser != null) {
      return noUser(this);
    }
    return orElse();
  }
}

abstract class NoUser implements UserState {
  const factory NoUser() = _$NoUserImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$ErrorImpl(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'UserState.error(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) initial,
    required TResult Function(Map<dynamic, dynamic> lk, UserModel user)
        initialLk,
    required TResult Function() loading,
    required TResult Function(String text) success,
    required TResult Function() noUser,
    required TResult Function(String text) error,
  }) {
    return error(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? initial,
    TResult? Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult? Function()? loading,
    TResult? Function(String text)? success,
    TResult? Function()? noUser,
    TResult? Function(String text)? error,
  }) {
    return error?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? initial,
    TResult Function(Map<dynamic, dynamic> lk, UserModel user)? initialLk,
    TResult Function()? loading,
    TResult Function(String text)? success,
    TResult Function()? noUser,
    TResult Function(String text)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Intial value) initial,
    required TResult Function(IntialLk value) initialLk,
    required TResult Function(Loading value) loading,
    required TResult Function(Success value) success,
    required TResult Function(NoUser value) noUser,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Intial value)? initial,
    TResult? Function(IntialLk value)? initialLk,
    TResult? Function(Loading value)? loading,
    TResult? Function(Success value)? success,
    TResult? Function(NoUser value)? noUser,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Intial value)? initial,
    TResult Function(IntialLk value)? initialLk,
    TResult Function(Loading value)? loading,
    TResult Function(Success value)? success,
    TResult Function(NoUser value)? noUser,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements UserState {
  const factory Error(final String text) = _$ErrorImpl;

  String get text;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
