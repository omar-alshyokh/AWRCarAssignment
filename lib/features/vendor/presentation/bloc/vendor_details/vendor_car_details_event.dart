part of 'vendor_car_details_bloc.dart';

abstract class VendorCarDetailsEvent extends Equatable {
  const VendorCarDetailsEvent();

  @override
  List<Object> get props => [];
}

class StartDelivery extends VendorCarDetailsEvent {
  final String carId;

  const StartDelivery({required this.carId});

  @override
  List<Object> get props => [carId];
}

class CompleteDelivery extends VendorCarDetailsEvent {
  final String carId;

  const CompleteDelivery({required this.carId});

  @override
  List<Object> get props => [carId];
}

