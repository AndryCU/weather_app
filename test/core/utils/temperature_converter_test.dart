import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/utils.dart';

void main() {
  group(
    'testing temperature conversion',
    () {
      const temperature = 303.15;
      test(
        'should convert to Celsius',
        () {
          final celsius =
              TemperatureHelper.convertTemperatureToCelsius(temperature);
          expect(celsius, '30.0°C');
        },
      );
      test(
        'should convert to Fahrenheit',
        () {
          final celsius =
              TemperatureHelper.convertTemperatureToFahrenheit(temperature);
          expect(celsius, '86.0°F');
        },
      );
    },
  );
}
