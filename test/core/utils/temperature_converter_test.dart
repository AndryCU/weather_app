import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/temperature_converter.dart';

void main() {
  group(
    'testing temperature conversion',
    () {
      const temperature = 303.15;
      test(
        'should convert to Celsius',
        () {
          final celsius = convertTemperatureToCelsius(temperature);
          expect(celsius, '30°C');
        },
      );
      test(
        'should convert to Fahrenheit',
        () {
          final celsius = convertTemperatureToFahrenheit(temperature);
          expect(celsius, '86°F');
        },
      );
    },
  );
}
