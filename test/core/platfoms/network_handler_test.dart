import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/platfoms/network_handler.dart';

import 'network_handler_test.mocks.dart';

@GenerateMocks([ApiHandler])
void main() {
  late MockApiHandler mockApiHandler;
  const geoCodingEndPoint = 'geo/1.0/direct';
  setUp(
    () {
      mockApiHandler = MockApiHandler();
    },
  );

  group('Response Api Handler', () {
    test(
      'should response success',
      () async {
        Map<String, String> body = {
          'lat': '12',
          'lon': '24',
          'appid': '',
          'units': 'metric',
        };
        final file = File('test/responses_examples/geoCoding_response.json')
            .readAsStringSync();
        when(mockApiHandler.get(path: geoCodingEndPoint, queryParameters: body))
            .thenAnswer((_) =>
                Future.value(Response(jsonDecode(file).toString(), 200)));
        final response = await mockApiHandler.get(
            path: geoCodingEndPoint, queryParameters: body);
        expect(response.statusCode, 200);
        verify(
            mockApiHandler.get(path: geoCodingEndPoint, queryParameters: body));
        verifyNoMoreInteractions(mockApiHandler);
      },
    );

    test(
      'should response an error',
      () async {
        Map<String, String> bodyFail = {
          'lon': '24',
          'appid': '',
          'units': 'metric',
        };
        when(mockApiHandler.get(
                path: geoCodingEndPoint, queryParameters: bodyFail))
            .thenThrow(Exception('Nothing to geocode'));
        expect(
            () async => await mockApiHandler.get(
                path: geoCodingEndPoint, queryParameters: bodyFail),
            throwsException);
        verify(mockApiHandler.get(
            path: geoCodingEndPoint, queryParameters: bodyFail));
        verifyNoMoreInteractions(mockApiHandler);
      },
    );
  });
}
