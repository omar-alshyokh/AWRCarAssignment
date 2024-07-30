part of 'vendor_car_details_bloc.dart';


abstract class VendorCarDetailsState extends Equatable {
  const VendorCarDetailsState();

  @override
  List<Object> get props => [];
}

class VendorCarDetailsInitial extends VendorCarDetailsState {}

class VendorCarDetailsLoading extends VendorCarDetailsState {}

class VendorCarDetailsLoaded extends VendorCarDetailsState {
  final CarEntity car;
  final LatLngBounds? latLngBounds;

  const VendorCarDetailsLoaded({required this.car,required this.latLngBounds});

  @override
  List<Object> get props => [car];
}

class VendorCarDetailsUpdatedToDelivering extends VendorCarDetailsState {}
class VendorCarDetailsUpdatedToDelivered extends VendorCarDetailsState {}

class VendorCarDetailsError extends VendorCarDetailsState {
  final BaseError error;

  const VendorCarDetailsError({required this.error});

  @override
  List<Object> get props => [error];
}
