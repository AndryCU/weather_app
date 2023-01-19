import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:weather_app/core/platfoms/network_handler.dart';
import 'package:weather_app/features/feth_location/data/repositories/geo_coding_repository_implementation.dart';
import 'package:weather_app/features/feth_location/domain/entities/geocoding/geo_coding_entity.dart';

import 'geo_coding_repository_implementation_test.mocks.dart';

@GenerateMocks([GeoCodingRepositoryImplantation, ApiHandler])
void main() {
  late MockGeoCodingRepositoryImplantation mockitoService;
  late MockApiHandler _apiHandler;
  late String json;
  late GeoCodingModel geoCodingModel;
  setUpAll(() async {
    //await setup();
    _apiHandler = MockApiHandler();
    mockitoService = MockGeoCodingRepositoryImplantation();
    json = File('test/responses_examples/geoCoding_response.json')
        .readAsStringSync();
    geoCodingModel = GeoCodingModel.fromJson(jsonDecode(json)[0]);
  });

  group(
    'GeoCoding repository',
    () {
      test(
        'should return empty list of locations',
        () async {
          //arrange

          //act
          when(mockitoService.fetchPositionByName('sadjkhksajdh')).thenAnswer(
              (realInvocation) async => Future.value(<GeoCodingModel>[]));
          var r = await mockitoService.fetchPositionByName('sadjkhksajdh');

          //assert
          expect(r.length, 0);
          verify(mockitoService.fetchPositionByName('sadjkhksajdh'));
          verifyNoMoreInteractions(mockitoService);
        },
      );

      test(
        'should return internet connection exception',
        () {
          //arrange

          //act
          when(mockitoService.fetchPositionByName('Havana'))
              .thenThrow(NoInternetException());
          //assert
          expect(() => mockitoService.fetchPositionByName('Havana'),
              throwsException);
          verify(mockitoService.fetchPositionByName('Havana'));
          verifyNoMoreInteractions(mockitoService);
        },
      );

      test(
        'should return a list of locations',
        () async {
          //arrange
          final file = File('test/responses_examples/geoCoding_response.json')
              .readAsStringSync();
          final t = jsonDecode(file) as List<dynamic>;
          List<GeoCodingModel> geocodingModelList = [];
          for (var a in t) {
            Map<String, dynamic> d = a as Map<String, dynamic>;
            geocodingModelList.add(GeoCodingModel.fromJson(d));
          }
          //act
          when(mockitoService.fetchPositionByName('Havana')).thenAnswer(
              (realInvocation) async => Future.value(geocodingModelList));
          final resultList = await mockitoService.fetchPositionByName('Havana');
          //assert
          expect(resultList.length, 5);
          expect(geocodingModelList.length, 5);
          expect(geocodingModelList, isA<List<GeoCodingModel>>());
          expect(resultList, isA<List<GeoCodingModel>>());
          expect(resultList, geocodingModelList);
          verify(mockitoService.fetchPositionByName('Havana'));
          verifyNoMoreInteractions(mockitoService);
        },
      );
    },
  );
}
