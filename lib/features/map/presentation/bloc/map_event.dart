part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {}

class GetCarsLocationEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}
