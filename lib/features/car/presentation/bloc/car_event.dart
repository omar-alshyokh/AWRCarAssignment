part of 'car_bloc.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();
}

class GetCarsEvent extends CarEvent {
  @override
  List<Object?> get props => [];
}

class AddCarEvent extends CarEvent {
  final CarModel car;

  const AddCarEvent({required this.car});

  @override
  List<Object?> get props => [car];
}

class LoadCarDetails extends CarEvent {
  final String carId;

  const LoadCarDetails({required this.carId});

  @override
  List<Object> get props => [carId];
}
