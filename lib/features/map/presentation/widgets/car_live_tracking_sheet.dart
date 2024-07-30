import 'dart:async';
import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_map_item_widget.dart';
import 'package:car_tracking_app/features/map/presentation/bloc/tracking_location/car_tracking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarLiveTrackingSheet extends StatefulWidget {
  final CarEntity car;

  const CarLiveTrackingSheet({super.key, required this.car});

  @override
  State<StatefulWidget> createState() => _CarLiveTrackingSheetState();
}

class _CarLiveTrackingSheetState extends State<CarLiveTrackingSheet> {
  late GoogleMapController _mapController;
  Marker? _carMarker;
  BitmapDescriptor? _pickUpMarkerIcon;
  BitmapDescriptor? _dropOffMarkerIcon;
  BitmapDescriptor? _carMarkerIcon;

  late CarLiveTrackingBloc _carLiveTrackingBloc;

  @override
  void initState() {
    super.initState();
    _carLiveTrackingBloc = findDep<CarLiveTrackingBloc>();
    _carLiveTrackingBloc.add(StartLiveTracking(widget.car));
    _loadCustomMarkers().then((_) {
      _initializeMarkers();
    });
  }

  Future<void> _loadCustomMarkers() async {
    _pickUpMarkerIcon =
        await getBitmapDescriptorFromAssetBytes(AppAssets.carPickUpMarker, 100);
    _dropOffMarkerIcon = await getBitmapDescriptorFromAssetBytes(
        AppAssets.carDropOffMarker, 100);
    _carMarkerIcon =
        await getBitmapDescriptorFromAssetBytes(AppAssets.carMarker, 65);
    if (mounted) setState(() {});
  }

  void _initializeMarkers() {
    _carMarker = Marker(
      markerId: MarkerId(widget.car.id),
      position: LatLng(widget.car.currentLocationLatitude,
          widget.car.currentLocationLongitude),
      icon: _carMarkerIcon ?? BitmapDescriptor.defaultMarker,
    );
  }

  void _updateCarMarker(LatLng newLocation, double bearing) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carMarker = _carMarker!.copyWith(
        positionParam: newLocation,
        rotationParam: bearing,
      );
      _mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
      if (mounted) setState(() {});
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtils.getScaledHeight(context, .7);
    final width = DeviceUtils.getScaledHeight(context, .8);
    return BaseBottomSheet(
      withDone: false,
      padding: EdgeInsets.zero,
      textHeader: translate.delivering_message,
      childContent: BlocConsumer<CarLiveTrackingBloc, CarLiveTrackingState>(
        bloc: _carLiveTrackingBloc,
        listener: (context, state) {
          if (state is CarLiveTrackingInProgress) {
            _updateCarMarker(state.currentLocation, state.bearing);
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(
              milliseconds: AppDurations.shortAnimationDuration,
            ),
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.car.currentLocationLatitude,
                          widget.car.currentLocationLongitude),
                      zoom: AppConstants.initialCameraZoom,
                    ),
                    zoomControlsEnabled: false,
                    markers: _carMarker != null
                        ? {
                            _carMarker!,
                            Marker(
                              markerId: const MarkerId('pick_up'),
                              position: LatLng(widget.car.pickUpLocationLatitude,
                                  widget.car.pickUpLocationLongitude),
                              icon: _pickUpMarkerIcon ??
                                  BitmapDescriptor.defaultMarker,
                            ),
                            Marker(
                              markerId: const MarkerId('drop_off'),
                              position: LatLng(widget.car.dropOffLocationLatitude,
                                  widget.car.dropOffLocationLongitude),
                              icon: _dropOffMarkerIcon ??
                                  BitmapDescriptor.defaultMarker,
                            ),
                          }
                        : {},
                    polylines: state is CarLiveTrackingInProgress
                        ? {
                            Polyline(
                              polylineId: const PolylineId('route'),
                              points: state.polylineCoordinates,
                              color: AppColors.blue,
                              width: 5,
                            ),
                          }
                        : {},
                  ),
                ),
                CarMapItemWidget(car: widget.car, width: width, height: height*.3)
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _carLiveTrackingBloc.close();
    super.dispose();
  }
}
