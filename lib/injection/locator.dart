import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/platfoms/network_handler.dart';

import '../core/platfoms/share_preferences_handler.dart';
import '../features/current_weather/data/repositories/current_weather_repository_implementation.dart';
import '../features/current_weather/domain/repositories/current_weather_repository.dart';
import '../features/current_weather/domain/usecases/list_current_weather_use_case.dart';
import '../features/feth_location/data/repositories/geo_coding_repository_implementation.dart';
import '../features/feth_location/domain/repositories/geo_coding_repository.dart';
import '../features/feth_location/domain/usecases/geo_coding_list.dart';

final locator = GetIt.instance;
Future<void> setup() async {
  locator.registerSingleton<ApiHandler>(ApiHandler());
  locator.registerSingleton<GeoCodingRepository>(
      GeoCodingRepositoryImplantation(locator()));
  locator.registerSingleton<CurrentWeatherRepository>(
      CurrentWeatherRepositoryImplementation(locator()));

  locator
      .registerSingleton<ListGeoCodingUseCase>(ListGeoCodingUseCase(locator()));

  locator.registerLazySingleton<CurrentWeatherUseCase>(
      () => CurrentWeatherUseCase(locator()));
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManager(locator()));
}
