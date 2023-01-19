import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/current_weather/domain/entities/wind_model.dart';

void main() {
  test(
    'testing WindModel.froJson()',
    () {
      final file = File('test/responses_examples/currentWeather_response.json')
          .readAsStringSync();
      final model = WindModel.fromJson(jsonDecode(file)['wind']);

      expect(model.speed, 2.81);
    },
  );
}
