import 'package:freezed_annotation/freezed_annotation.dart';

part 'temperature_entity.freezed.dart';
part 'temperature_entity.g.dart';

@freezed
class TemperatureEntity with _$TemperatureEntity {
  factory TemperatureEntity({
    required double temp,
    required double pressure,
    required int humidity,
  }) = _TemperatureEntity;
  factory TemperatureEntity.fromJson(Map<String, Object?> json) =>
      _$TemperatureEntityFromJson(json);
}
