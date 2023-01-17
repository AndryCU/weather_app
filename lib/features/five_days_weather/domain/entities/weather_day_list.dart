import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/temperature_entity.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/weather_next_days_entity.dart';
part 'weather_day_list.freezed.dart';
part 'weather_day_list.g.dart';

@freezed
class WeatherList with _$WeatherList {
  @JsonSerializable(explicitToJson: true)
  factory WeatherList({
    required int dt,
    required TemperatureEntity main,
    required String dt_txt,
    required List<WeatherGeneralEntity> weather,
  }) = _WeatherList;
  factory WeatherList.fromJson(Map<String, Object?> json) =>
      _$WeatherListFromJson(json);
}
