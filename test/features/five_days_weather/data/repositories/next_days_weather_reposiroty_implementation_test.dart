import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/five_days_weather/data/repositories/next_days_weather_reposiroty_implementation.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';

import '../../../../core/platfoms/network_handler_test.mocks.dart';
import 'next_days_weather_reposiroty_implementation_test.mocks.dart';

@GenerateMocks([NextDaysWeatherRepositoryImplementation])
void main() {
  late MockNextDaysWeatherRepositoryImplementation _mockRepoImple;
  late MockApiHandler _apiHandler;

  setUpAll(
    () {
      _mockRepoImple = MockNextDaysWeatherRepositoryImplementation();
      _apiHandler = MockApiHandler();
    },
  );

  group(
    'Testing 5 days repository',
    () {
      const lat = 23.135305;
      const lon = -82.3589631;
      test(
        'should return NoInternetException',
        () async {
          //arrange

          //act
          when(_mockRepoImple.getNextDaysWeather(lat: lat, lon: lon))
              .thenAnswer((realInvocation) => Future.value(Left(Exception())));
          final response =
              await _mockRepoImple.getNextDaysWeather(lat: lat, lon: lon);
          //assert
          response.fold((l) {
            expect(l, isA<Exception>());
            verify(_mockRepoImple.getNextDaysWeather(lat: lat, lon: lon));
            verifyNoMoreInteractions(_mockRepoImple);
          }, (r) {});
        },
      );

      test(
        'should return cucssess',
        () async {
          //arrange
          final file = File('test/responses_examples/next_days_weather.json')
              .readAsStringSync();
          final map = jsonDecode(file) as Map<String, dynamic>;
          //act
          when(_mockRepoImple.getNextDaysWeather(lat: lat, lon: lon))
              .thenAnswer((realInvocation) =>
                  Future.value(Right(WeatherByDaysMainEntity.fromJson(map))));

          final response =
              await _mockRepoImple.getNextDaysWeather(lat: lat, lon: lon);
          //assert
          response.fold((l) {}, (r) {
            expect(r, isA<WeatherByDaysMainEntity>());
            expect(r, isA<WeatherByDaysMainEntity>());
            verify(_mockRepoImple.getNextDaysWeather(lat: lat, lon: lon));
            verifyNoMoreInteractions(_mockRepoImple);
          });
        },
      );
    },
  );
}
