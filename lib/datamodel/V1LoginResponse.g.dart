// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'V1LoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_V1LoginResponse _$$_V1LoginResponseFromJson(Map<String, dynamic> json) =>
    _$_V1LoginResponse(
      code: json['code'] as int?,
      result: json['result'] == null
          ? null
          : v1Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_V1LoginResponseToJson(_$_V1LoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
    };

_$_v1Result _$$_v1ResultFromJson(Map<String, dynamic> json) => _$_v1Result(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$_v1ResultToJson(_$_v1Result instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
