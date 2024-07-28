part of 'car_tracking_bloc.dart';

abstract class CarLiveTrackingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartLiveTracking extends CarLiveTrackingEvent {
  final CarEntity car;

  StartLiveTracking(this.car);

  @override
  List<Object> get props => [car];
}
