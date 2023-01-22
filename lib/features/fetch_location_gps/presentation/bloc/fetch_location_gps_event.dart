part of 'fetch_location_gps_bloc.dart';

abstract class FetchLocationGpsEvent extends Equatable {
  const FetchLocationGpsEvent();

  @override
  List<Object> get props => [];
}

class FetchLocationGpsStarted extends FetchLocationGpsEvent {}

class FetchLocationReset extends FetchLocationGpsEvent {}
