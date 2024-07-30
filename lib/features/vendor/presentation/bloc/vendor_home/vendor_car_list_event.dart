part of 'vendor_car_list_bloc.dart';

abstract class VendorCarListEvent extends Equatable {
  const VendorCarListEvent();

  @override
  List<Object> get props => [];
}

class VendorLoadCars extends VendorCarListEvent {}

