import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';

void main() {
  test(
    'testing WeatherList.fromJson()',
    () {
      //arrange
      final file = File('test/responses_examples/next_days_weather.json')
          .readAsStringSync();
      final map = jsonDecode(file) as Map<String, dynamic>;
      //act
      final model = WeatherByDaysMainEntity.fromJson(map);
      //assert
      expect(model, isA<WeatherByDaysMainEntity>());
      expect(model.list.length, 40);
      expect(model.list.first.dt, 1674097200);
      expect(model.list.first.weather.first.icon, '04n');
      expect(model.list.first.weather.first.main, 'Clouds');
      expect(model.list.first.weather.first.description, 'overcast clouds');
      expect(model.list.first.main.humidity, 82);
      expect(model.list.first.main.pressure, 1018);
      expect(model.list.first.main.temp, 292.37);
    },
  );
}
