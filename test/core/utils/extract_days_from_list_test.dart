import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/extract_days_from_list.dart';

void main() {
  group(
    'testing management dates',
    () {
      const unixTime = 1610685149000;
      test('test getNameDayOfWeek', () {
        final result = CustomDaysUtil.getNameDayOfWeek(unixTime);
        expect(result, 'Thursday');
      });

      test('test day of getHourOfDay', () {
        final result = CustomDaysUtil.getHourOfDay(1610685149);
        expect(result, '11 PM');
      });

      test('test day of getDayOfMonth', () {
        final result = CustomDaysUtil.getDayOfMonth(unixTime);
        expect(result, 'Jan 14');
      });
    },
  );
}
