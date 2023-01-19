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
          when(mockitoService.getPositionByName('sadjkhksajdh')).thenAnswer(
              (realInvocation) async => Future.value(<GeoCodingModel>[]));
          var r = await mockitoService.getPositionByName('sadjkhksajdh');

          //assert
          expect(r.length, 0);
          verify(mockitoService.getPositionByName('sadjkhksajdh'));
          verifyNoMoreInteractions(mockitoService);
        },
      );

      test(
        'should return internet connection exception',
        () {
          //arrange

          //act
          when(mockitoService.getPositionByName('Havana'))
              .thenThrow(NoInternetException());
          //assert
          expect(() => mockitoService.getPositionByName('Havana'),
              throwsException);
          verify(mockitoService.getPositionByName('Havana'));
          verifyNoMoreInteractions(mockitoService);
        },
      );
    },
  );
}
