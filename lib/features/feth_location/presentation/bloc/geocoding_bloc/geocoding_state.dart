part of 'geocoding_bloc.dart';

abstract class GeoCodingBlocState extends Equatable {
  const GeoCodingBlocState();
  @override
  List<Object> get props => [];
}

class GeoCodingInitialState extends GeoCodingBlocState {}

class GeoCodingLoadingState extends GeoCodingBlocState {}

class GeoCodingLoadedState extends GeoCodingBlocState {
  final List<GeoCodingModel> newCountries;
  const GeoCodingLoadedState({required this.newCountries});
  @override
  List<Object> get props => [newCountries];
}

class GeoCodingNoResultsState extends GeoCodingBlocState {}

class GeoCodingErrorState extends GeoCodingBlocState {
  final Exception exception;
  const GeoCodingErrorState(
    this.exception,
  );
  @override
  List<Object> get props => [exception];
}
