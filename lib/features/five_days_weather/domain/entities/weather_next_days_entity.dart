import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather_next_days_entity.freezed.dart';
part 'weather_next_days_entity.g.dart';

@freezed
class WeatherGeneralEntity with _$WeatherGeneralEntity {
  factory WeatherGeneralEntity({
    required String main,
    required String description,
    required String icon,
  }) = _WeatherGeneralEntity;
  factory WeatherGeneralEntity.fromJson(Map<String, Object?> json) =>
      _$WeatherGeneralEntityFromJson(json);
}
