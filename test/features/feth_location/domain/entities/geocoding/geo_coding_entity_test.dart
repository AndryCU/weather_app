import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/feth_location/domain/entities/geocoding/geo_coding_entity.dart';

void main() {
  test(
    'Testing GeoCodingModel.fromJson()',
    () {
      final file = File('test/responses_examples/geoCoding_response.json')
          .readAsStringSync();
      final model =
          GeoCodingModel.fromJson(jsonDecode(file)[0] as Map<String, dynamic>);
      expect(model.country, 'CU');
      expect(model.lat, 23.135305);
      expect(model.lon, -82.3589631);
      expect(model.state, 'Havana');
    },
  );
}
