import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/injection/locator.dart';

import '../../domain/repositories/location_gps_repository.dart';

part 'fetch_location_gps_event.dart';
part 'fetch_location_gps_state.dart';

class FetchLocationGpsBloc
    extends Bloc<FetchLocationGpsEvent, FetchLocationGpsState> {
  FetchLocationGpsBloc() : super(FetchLocationGpsInitial()) {
    on<FetchLocationGpsStarted>((event, emit) async {
      Position? position;
      final serviceStatus = await _serviceEnable();
      var permissionStatus = await _permissionsGranted();
      if (permissionStatus == LocationPermission.denied ||
          permissionStatus == LocationPermission.deniedForever ||
          permissionStatus == LocationPermission.unableToDetermine) {
        permissionStatus = await Geolocator.requestPermission();
      }
      if (serviceStatus &&
          (permissionStatus == LocationPermission.always ||
              permissionStatus == LocationPermission.whileInUse)) {
        try {
          emit(FetchLocationGpsLoading());
          position =
              await locator.get<LocationGpsRepository>().getCurrentLocation();
        } catch (e) {
          emit(FetchLocationGpsError());
        }
        position == null
            ? emit(FetchLocationGpsError())
            : emit(
                FetchLocationGpsLoaded(position.latitude, position.longitude));
      } else {
        if (!serviceStatus) {
          emit(FetchLocationGpsServiceError());
        } else {
          permissionStatus == LocationPermission.deniedForever
              ? emit(FetchLocationGpsDenyForever())
              : emit(FetchLocationGpsPermissionError(permissionStatus));
        }
      }
    });
    on<FetchLocationReset>((event, emit) => emit(FetchLocationGpsInitial()));
  }
  Future<bool> _serviceEnable() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> _permissionsGranted() async =>
      await Geolocator.checkPermission();
}
