import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/five_days_weather/data/repositories/next_days_weather_reposiroty_implementation.dart';

import '../core/platfoms/platfoms.dart';
import '../features/current_weather/data/repositories/current_weather_repository_implementation.dart';
import '../features/current_weather/domain/repositories/current_weather_repository.dart';
import '../features/current_weather/domain/usecases/list_current_weather_use_case.dart';
import '../features/fetch_location_gps/data/repositories/location_gps_repository_implementarion.dart';
import '../features/fetch_location_gps/domain/repositories/location_gps_repository.dart';
import '../features/feth_location/data/repositories/geo_coding_repository_implementation.dart';
import '../features/feth_location/domain/repositories/geo_coding_repository.dart';
import '../features/feth_location/domain/usecases/geo_coding_list.dart';
import '../features/five_days_weather/domain/repositories/next_days_repository.dart';
import '../features/five_days_weather/domain/usecases/next_days_use_case.dart';

final locator = GetIt.instance;
Future<void> setup() async {
  locator.registerSingleton<ApiHandler>(ApiHandler());
  locator.registerSingleton<GeoCodingRepository>(
      GeoCodingRepositoryImplantation(locator()));
  locator.registerSingleton<CurrentWeatherRepository>(
      CurrentWeatherRepositoryImplementation(locator()));
  locator.registerSingleton<NextDaysWeatherRepository>(
      NextDaysWeatherRepositoryImplementation());
  locator.registerSingleton<NextDaysUseCase>(NextDaysUseCase(locator()));

  locator
      .registerSingleton<ListGeoCodingUseCase>(ListGeoCodingUseCase(locator()));

  locator.registerLazySingleton<CurrentWeatherUseCase>(
      () => CurrentWeatherUseCase(locator()));
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManager(locator()));

  locator.registerSingleton<LocationGpsRepository>(
      LocationGpsRepositoryImplementation());
}
