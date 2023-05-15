// To parse this JSON data, do
//
//     final v1LoginResponse = v1LoginResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'V1LoginResponse.freezed.dart';
part 'V1LoginResponse.g.dart';

V1LoginResponse v1LoginResponseFromJson(String str) => V1LoginResponse.fromJson(json.decode(str));

String v1LoginResponseToJson(V1LoginResponse data) => json.encode(data.toJson());

@freezed
class V1LoginResponse with _$V1LoginResponse {
  const factory V1LoginResponse({
    int? code,
    v1Result? result,
  }) = _V1LoginResponse;

  factory V1LoginResponse.fromJson(Map<String, dynamic> json) => _$V1LoginResponseFromJson(json);
}

@freezed
class v1Result with _$v1Result {
  const factory v1Result({
    String? token,
  }) = _v1Result;

  factory v1Result.fromJson(Map<String, dynamic> json) => _$v1ResultFromJson(json);
}
