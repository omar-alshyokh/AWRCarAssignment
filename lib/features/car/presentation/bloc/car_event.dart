part of 'car_bloc.dart';

sealed class CarEvent extends Equatable {}

class GetCarsEvent extends CarEvent {
  @override
  List<Object?> get props => [];
}

class AddCarEvent extends CarEvent {
  final CarModel car;

  AddCarEvent(this.car);

  @override
  List<Object?> get props => [car];
}
