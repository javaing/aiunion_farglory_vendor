// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ServerSetting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServerSetting _$ServerSettingFromJson(Map<String, dynamic> json) {
  return _ServerSetting.fromJson(json);
}

/// @nodoc
mixin _$ServerSetting {
  int? get page => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  List<Setting>? get result => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServerSettingCopyWith<ServerSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerSettingCopyWith<$Res> {
  factory $ServerSettingCopyWith(
          ServerSetting value, $Res Function(ServerSetting) then) =
      _$ServerSettingCopyWithImpl<$Res, ServerSetting>;
  @useResult
  $Res call({int? page, int? total, List<Setting>? result, int? pageSize});
}

/// @nodoc
class _$ServerSettingCopyWithImpl<$Res, $Val extends ServerSetting>
    implements $ServerSettingCopyWith<$Res> {
  _$ServerSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? total = freezed,
    Object? result = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Setting>?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ServerSettingCopyWith<$Res>
    implements $ServerSettingCopyWith<$Res> {
  factory _$$_ServerSettingCopyWith(
          _$_ServerSetting value, $Res Function(_$_ServerSetting) then) =
      __$$_ServerSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? page, int? total, List<Setting>? result, int? pageSize});
}

/// @nodoc
class __$$_ServerSettingCopyWithImpl<$Res>
    extends _$ServerSettingCopyWithImpl<$Res, _$_ServerSetting>
    implements _$$_ServerSettingCopyWith<$Res> {
  __$$_ServerSettingCopyWithImpl(
      _$_ServerSetting _value, $Res Function(_$_ServerSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? total = freezed,
    Object? result = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$_ServerSetting(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Setting>?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ServerSetting implements _ServerSetting {
  const _$_ServerSetting(
      {this.page, this.total, final List<Setting>? result, this.pageSize})
      : _result = result;

  factory _$_ServerSetting.fromJson(Map<String, dynamic> json) =>
      _$$_ServerSettingFromJson(json);

  @override
  final int? page;
  @override
  final int? total;
  final List<Setting>? _result;
  @override
  List<Setting>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? pageSize;

  @override
  String toString() {
    return 'ServerSetting(page: $page, total: $total, result: $result, pageSize: $pageSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ServerSetting &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._result, _result) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, total,
      const DeepCollectionEquality().hash(_result), pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ServerSettingCopyWith<_$_ServerSetting> get copyWith =>
      __$$_ServerSettingCopyWithImpl<_$_ServerSetting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ServerSettingToJson(
      this,
    );
  }
}

abstract class _ServerSetting implements ServerSetting {
  const factory _ServerSetting(
      {final int? page,
      final int? total,
      final List<Setting>? result,
      final int? pageSize}) = _$_ServerSetting;

  factory _ServerSetting.fromJson(Map<String, dynamic> json) =
      _$_ServerSetting.fromJson;

  @override
  int? get page;
  @override
  int? get total;
  @override
  List<Setting>? get result;
  @override
  int? get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$_ServerSettingCopyWith<_$_ServerSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
mixin _$Setting {
  int? get id => throw _privateConstructorUsedError;
  String? get resultVar => throw _privateConstructorUsedError;
  String? get val => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingCopyWith<Setting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res, Setting>;
  @useResult
  $Res call(
      {int? id,
      String? resultVar,
      String? val,
      String? type,
      String? name,
      String? memo});
}

/// @nodoc
class _$SettingCopyWithImpl<$Res, $Val extends Setting>
    implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resultVar = freezed,
    Object? val = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      resultVar: freezed == resultVar
          ? _value.resultVar
          : resultVar // ignore: cast_nullable_to_non_nullable
              as String?,
      val: freezed == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$$_SettingCopyWith(
          _$_Setting value, $Res Function(_$_Setting) then) =
      __$$_SettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? resultVar,
      String? val,
      String? type,
      String? name,
      String? memo});
}

/// @nodoc
class __$$_SettingCopyWithImpl<$Res>
    extends _$SettingCopyWithImpl<$Res, _$_Setting>
    implements _$$_SettingCopyWith<$Res> {
  __$$_SettingCopyWithImpl(_$_Setting _value, $Res Function(_$_Setting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resultVar = freezed,
    Object? val = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? memo = freezed,
  }) {
    return _then(_$_Setting(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      resultVar: freezed == resultVar
          ? _value.resultVar
          : resultVar // ignore: cast_nullable_to_non_nullable
              as String?,
      val: freezed == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Setting implements _Setting {
  const _$_Setting(
      {this.id, this.resultVar, this.val, this.type, this.name, this.memo});

  factory _$_Setting.fromJson(Map<String, dynamic> json) =>
      _$$_SettingFromJson(json);

  @override
  final int? id;
  @override
  final String? resultVar;
  @override
  final String? val;
  @override
  final String? type;
  @override
  final String? name;
  @override
  final String? memo;

  @override
  String toString() {
    return 'Setting(id: $id, resultVar: $resultVar, val: $val, type: $type, name: $name, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Setting &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resultVar, resultVar) ||
                other.resultVar == resultVar) &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, resultVar, val, type, name, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingCopyWith<_$_Setting> get copyWith =>
      __$$_SettingCopyWithImpl<_$_Setting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingToJson(
      this,
    );
  }
}

abstract class _Setting implements Setting {
  const factory _Setting(
      {final int? id,
      final String? resultVar,
      final String? val,
      final String? type,
      final String? name,
      final String? memo}) = _$_Setting;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$_Setting.fromJson;

  @override
  int? get id;
  @override
  String? get resultVar;
  @override
  String? get val;
  @override
  String? get type;
  @override
  String? get name;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$$_SettingCopyWith<_$_Setting> get copyWith =>
      throw _privateConstructorUsedError;
}
