part of 'car_tracking_bloc.dart';

abstract class CarLiveTrackingState extends Equatable {
  @override
  List<Object> get props => [];
}

class CarLiveTrackingInitial extends CarLiveTrackingState {}

class CarLiveTrackingInProgress extends CarLiveTrackingState {
  final LatLng currentLocation;
  final double bearing;
  final List<LatLng> polylineCoordinates;



  CarLiveTrackingInProgress({
    required this.currentLocation,
    required this.bearing,
    required this.polylineCoordinates

  });

  @override
  List<Object> get props => [currentLocation,polylineCoordinates];
}
