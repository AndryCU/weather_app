import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/sun_entity.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/weather_day_list.dart';
part 'next_days_weather_main.freezed.dart';
part 'next_days_weather_main.g.dart';

@freezed
class WeatherByDaysMainEntity with _$WeatherByDaysMainEntity {
  @JsonSerializable(explicitToJson: true)
  factory WeatherByDaysMainEntity({
    required List<WeatherList> list,
    required SunDataEntity city,
  }) = _WeatherByDaysMainEntity;

  factory WeatherByDaysMainEntity.fromJson(Map<String, Object?> json) =>
      _$WeatherByDaysMainEntityFromJson(json);
}
