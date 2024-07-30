part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class MapInitial extends MapState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MapInitial';
}

class MapLoading extends MapState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MapLoading';
}


class GetCarsLocationSuccess extends MapState {
  final List<CarEntity> cars;
  final LatLngBounds? latLngBounds;

  const GetCarsLocationSuccess({required this.cars,required this.latLngBounds});

  @override
  List<Object> get props => [cars];

  @override
  String toString() => 'GetCarsLocationSuccess';
}

class GetCarsLocationFailed extends MapState {
  final BaseError error;

  const GetCarsLocationFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetCarsLocationFailed';
}
