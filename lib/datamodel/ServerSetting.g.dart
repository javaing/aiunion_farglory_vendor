// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServerSetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ServerSetting _$$_ServerSettingFromJson(Map<String, dynamic> json) =>
    _$_ServerSetting(
      page: json['page'] as int?,
      total: json['total'] as int?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Setting.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$$_ServerSettingToJson(_$_ServerSetting instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total': instance.total,
      'result': instance.result,
      'pageSize': instance.pageSize,
    };

_$_Setting _$$_SettingFromJson(Map<String, dynamic> json) => _$_Setting(
      id: json['id'] as int?,
      resultVar: json['resultVar'] as String?,
      val: json['val'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$_SettingToJson(_$_Setting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resultVar': instance.resultVar,
      'val': instance.val,
      'type': instance.type,
      'name': instance.name,
      'memo': instance.memo,
    };
