import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/current_weather/domain/entities/current_weather_entities.dart';

void main() {
  test(
    'testing CurrentWeather.fromJson()',
    () {
      //arrange
      final file = File('test/responses_examples/currentWeather_response.json')
          .readAsStringSync();
      //act
      final model = CurrentWeatherModel.fromJson(
          jsonDecode(file) as Map<String, dynamic>);

      //assert
      expect(model, isA<CurrentWeatherModel>());
      expect(model.dt, 1674093475);
      expect(model.main.humidity, 82);
      expect(model.main.pressure, 1018);
      expect(model.main.temp, 19.22);
      expect(model.sys.sunrise, 1674043954);
      expect(model.sys.sunset, 1674083197);
      expect(model.weather.first.description, 'overcast clouds');
      expect(model.weather.first.icon, '04n');
      expect(model.weather.first.main, 'Clouds');
      expect(model.wind.speed, 2.81);
    },
  );
}
