import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/current_weather/domain/entities/current_weather_entities.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/weather_next_days_entity.dart';

import '../../../five_days_weather/domain/entities/sun_entity.dart';
import '../../../five_days_weather/domain/entities/temperature_entity.dart';
part 'current_weather_entity.freezed.dart';
part 'current_weather_entity.g.dart';

@freezed
class CurrentWeatherModel with _$CurrentWeatherModel {
  @JsonSerializable(explicitToJson: true)
  factory CurrentWeatherModel({
    required WindModel wind,
    required int dt,
    required List<WeatherGeneralEntity> weather,
    required TemperatureEntity main,
    required SunDataEntity sys,
  }) = _CurrentWeatherModel;

  factory CurrentWeatherModel.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherModelFromJson(json);
}
