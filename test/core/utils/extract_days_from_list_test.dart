import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/utils.dart';

void main() {
  group(
    'testing management dates',
    () {
      const unixTime = 1610685149000;
      test('test getNameDayOfWeek', () {
        final result = CustomDaysUtils.getNameDayOfWeek(unixTime);
        expect(result, 'Thursday');
      });

      test('test day of getHourOfDay', () {
        final result = CustomDaysUtils.getHourOfDay(1610685149);
        expect(result, '11 PM');
      });

      test('test day of getDayOfMonth', () {
        final result = CustomDaysUtils.getDayOfMonth(unixTime);
        expect(result, 'Jan 14');
      });
    },
  );
}
