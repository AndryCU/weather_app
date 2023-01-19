import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'testing temperature conversion',
    () {
      const temperature = 303.15;
      test(
        'should convert to Celsius',
        () {
          final celsius = '${(temperature - 273.15).round()}°C';
          expect(celsius, '30°C');
        },
      );
      test(
        'should convert to Fahrenheit',
        () {
          final celsius = '${((temperature - 273.15) * 1.8 + 32).round()}°F';
          expect(celsius, '86°F');
        },
      );
    },
  );
}
