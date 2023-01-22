part of 'fetch_location_gps_bloc.dart';

abstract class FetchLocationGpsState extends Equatable {
  const FetchLocationGpsState();

  @override
  List<Object> get props => [];
}

class FetchLocationGpsInitial extends FetchLocationGpsState {}

class FetchLocationGpsLoading extends FetchLocationGpsState {}

class FetchLocationGpsLoaded extends FetchLocationGpsState {
  final double lat, lon;

  const FetchLocationGpsLoaded(this.lat, this.lon);
  @override
  List<Object> get props => [lat, lon];
}

class FetchLocationGpsError extends FetchLocationGpsState {}

class FetchLocationGpsServiceError extends FetchLocationGpsState {}

class FetchLocationGpsPermissionError extends FetchLocationGpsState {}
