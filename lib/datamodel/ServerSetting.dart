// To parse this JSON data, do
//
//     final serverSetting = serverSettingFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'ServerSetting.freezed.dart';
part 'ServerSetting.g.dart';

ServerSetting serverSettingFromJson(String str) => ServerSetting.fromJson(json.decode(str));

String serverSettingToJson(ServerSetting data) => json.encode(data.toJson());

@freezed
class ServerSetting with _$ServerSetting {
  const factory ServerSetting({
    int? page,
    int? total,
    List<Setting>? result,
    int? pageSize,
  }) = _ServerSetting;

  factory ServerSetting.fromJson(Map<String, dynamic> json) => _$ServerSettingFromJson(json);
}

@freezed
class Setting with _$Setting {
  const factory Setting({
    int? id,
    String? resultVar,
    String? val,
    String? type,
    String? name,
    String? memo,
  }) = _Setting;

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);
}
