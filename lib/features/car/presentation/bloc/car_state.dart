part of 'car_bloc.dart';

@immutable
abstract class CarState extends Equatable {
  const CarState();
}

class CarInitial extends CarState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'CarInitial';
}

class CarLoading extends CarState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'CarLoading';
}
class AddCarLoading extends CarState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AddCarLoading';
}

class GetCarsSuccess extends CarState {
  final List<CarEntity> cars;

  const GetCarsSuccess({required this.cars});

  @override
  List<Object> get props => [cars];

  @override
  String toString() => 'GetCarsSuccess';
}

class GetCarsFailed extends CarState {
  final BaseError error;

  const GetCarsFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetCarsFailed';
}

class AddCarSuccess extends CarState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AddCarSuccess';
}

class AddCarFailed extends CarState {
  final BaseError error;

  const AddCarFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddCarFailed';
}
