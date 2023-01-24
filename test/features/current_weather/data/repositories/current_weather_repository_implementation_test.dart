import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:weather_app/features/current_weather/data/repositories/current_weather_repository_implementation.dart';
import 'package:weather_app/features/current_weather/domain/entities/current_weather_entities.dart';

import 'current_weather_repository_implementation_test.mocks.dart';

@GenerateMocks([CurrentWeatherRepositoryImplementation])
void main() {
  const lat = 23.135305;
  const lon = -82.3589631;
  late MockCurrentWeatherRepositoryImplementation mockitoService;
  late String file;
  late CurrentWeatherModel model;
  setUpAll(() {
    mockitoService = MockCurrentWeatherRepositoryImplementation();
    file = File('test/responses_examples/currentWeather_response.json')
        .readAsStringSync();
    model = CurrentWeatherModel.fromJson(jsonDecode(file));
  });
  group(
    'CurrentWeather repository',
    () {
      test(
        'should return an internet exception',
        () {
          //arrange

          //act
          when(mockitoService.fetchCurrentWeather(lat: lat, lon: lon))
              .thenThrow(NoInternetException());
          expect(() => mockitoService.fetchCurrentWeather(lat: lat, lon: lon),
              throwsException);
          verify(mockitoService.fetchCurrentWeather(lat: lat, lon: lon));
          verifyNoMoreInteractions(mockitoService);
        },
      );

      test(
        'should return the weather for next days',
        () async {
          //arrange

          //act
          when(mockitoService.fetchCurrentWeather(lat: lat, lon: lon))
              .thenAnswer((realInvocation) => Future.value(Right(model)));
          final response =
              await mockitoService.fetchCurrentWeather(lat: lat, lon: lon);

          //assert
          response.fold((l) {}, (r) {
            expect(r, isA<CurrentWeatherModel>());
            expect(r, isA<CurrentWeatherModel>());
            verify(mockitoService.fetchCurrentWeather(lat: lat, lon: lon));
            verifyNoMoreInteractions(mockitoService);
          });
        },
      );
    },
  );
}
