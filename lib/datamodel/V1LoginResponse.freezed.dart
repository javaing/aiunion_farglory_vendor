// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'V1LoginResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

V1LoginResponse _$V1LoginResponseFromJson(Map<String, dynamic> json) {
  return _V1LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$V1LoginResponse {
  int? get code => throw _privateConstructorUsedError;
  v1Result? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $V1LoginResponseCopyWith<V1LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $V1LoginResponseCopyWith<$Res> {
  factory $V1LoginResponseCopyWith(
          V1LoginResponse value, $Res Function(V1LoginResponse) then) =
      _$V1LoginResponseCopyWithImpl<$Res, V1LoginResponse>;
  @useResult
  $Res call({int? code, v1Result? result});

  $v1ResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$V1LoginResponseCopyWithImpl<$Res, $Val extends V1LoginResponse>
    implements $V1LoginResponseCopyWith<$Res> {
  _$V1LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as v1Result?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $v1ResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $v1ResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_V1LoginResponseCopyWith<$Res>
    implements $V1LoginResponseCopyWith<$Res> {
  factory _$$_V1LoginResponseCopyWith(
          _$_V1LoginResponse value, $Res Function(_$_V1LoginResponse) then) =
      __$$_V1LoginResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, v1Result? result});

  @override
  $v1ResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$_V1LoginResponseCopyWithImpl<$Res>
    extends _$V1LoginResponseCopyWithImpl<$Res, _$_V1LoginResponse>
    implements _$$_V1LoginResponseCopyWith<$Res> {
  __$$_V1LoginResponseCopyWithImpl(
      _$_V1LoginResponse _value, $Res Function(_$_V1LoginResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? result = freezed,
  }) {
    return _then(_$_V1LoginResponse(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as v1Result?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_V1LoginResponse implements _V1LoginResponse {
  const _$_V1LoginResponse({this.code, this.result});

  factory _$_V1LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$$_V1LoginResponseFromJson(json);

  @override
  final int? code;
  @override
  final v1Result? result;

  @override
  String toString() {
    return 'V1LoginResponse(code: $code, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_V1LoginResponse &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_V1LoginResponseCopyWith<_$_V1LoginResponse> get copyWith =>
      __$$_V1LoginResponseCopyWithImpl<_$_V1LoginResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_V1LoginResponseToJson(
      this,
    );
  }
}

abstract class _V1LoginResponse implements V1LoginResponse {
  const factory _V1LoginResponse({final int? code, final v1Result? result}) =
      _$_V1LoginResponse;

  factory _V1LoginResponse.fromJson(Map<String, dynamic> json) =
      _$_V1LoginResponse.fromJson;

  @override
  int? get code;
  @override
  v1Result? get result;
  @override
  @JsonKey(ignore: true)
  _$$_V1LoginResponseCopyWith<_$_V1LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

v1Result _$v1ResultFromJson(Map<String, dynamic> json) {
  return _v1Result.fromJson(json);
}

/// @nodoc
mixin _$v1Result {
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $v1ResultCopyWith<v1Result> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $v1ResultCopyWith<$Res> {
  factory $v1ResultCopyWith(v1Result value, $Res Function(v1Result) then) =
      _$v1ResultCopyWithImpl<$Res, v1Result>;
  @useResult
  $Res call({String? token});
}

/// @nodoc
class _$v1ResultCopyWithImpl<$Res, $Val extends v1Result>
    implements $v1ResultCopyWith<$Res> {
  _$v1ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_v1ResultCopyWith<$Res> implements $v1ResultCopyWith<$Res> {
  factory _$$_v1ResultCopyWith(
          _$_v1Result value, $Res Function(_$_v1Result) then) =
      __$$_v1ResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? token});
}

/// @nodoc
class __$$_v1ResultCopyWithImpl<$Res>
    extends _$v1ResultCopyWithImpl<$Res, _$_v1Result>
    implements _$$_v1ResultCopyWith<$Res> {
  __$$_v1ResultCopyWithImpl(
      _$_v1Result _value, $Res Function(_$_v1Result) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_$_v1Result(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_v1Result implements _v1Result {
  const _$_v1Result({this.token});

  factory _$_v1Result.fromJson(Map<String, dynamic> json) =>
      _$$_v1ResultFromJson(json);

  @override
  final String? token;

  @override
  String toString() {
    return 'v1Result(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_v1Result &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_v1ResultCopyWith<_$_v1Result> get copyWith =>
      __$$_v1ResultCopyWithImpl<_$_v1Result>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_v1ResultToJson(
      this,
    );
  }
}

abstract class _v1Result implements v1Result {
  const factory _v1Result({final String? token}) = _$_v1Result;

  factory _v1Result.fromJson(Map<String, dynamic> json) = _$_v1Result.fromJson;

  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$_v1ResultCopyWith<_$_v1Result> get copyWith =>
      throw _privateConstructorUsedError;
}
