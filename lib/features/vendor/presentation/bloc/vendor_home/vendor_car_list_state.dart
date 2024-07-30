part of 'vendor_car_list_bloc.dart';

abstract class VendorCarListState extends Equatable {
  const VendorCarListState();

  @override
  List<Object> get props => [];
}

class VendorCarListInitial extends VendorCarListState {}

class VendorCarListLoading extends VendorCarListState {}

class VendorCarListLoaded extends VendorCarListState {
  final List<CarEntity> cars;

  const VendorCarListLoaded({required this.cars});

  @override
  List<Object> get props => [cars];
}

class VendorCarListError extends VendorCarListState {
  final BaseError error;

  const VendorCarListError({required this.error});

  @override
  List<Object> get props => [error];
}
