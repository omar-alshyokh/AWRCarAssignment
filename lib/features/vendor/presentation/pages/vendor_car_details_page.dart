import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_map_item_widget.dart';
import 'package:car_tracking_app/features/vendor/presentation/bloc/vendor_details/vendor_car_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorCarDetailsPage extends BaseAppStatefulWidget {
  final CarEntity car;

  const VendorCarDetailsPage({super.key, required this.car});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() =>
      _VendorCarDetailsViewState();
}

class _VendorCarDetailsViewState extends BaseAppState<VendorCarDetailsPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  BitmapDescriptor? _pickUpMarkerIcon;
  BitmapDescriptor? _dropOffMarkerIcon;

  late final VendorCarDetailsBloc _bloc;

  late CarEntity _car;

  @override
  void initState() {
    super.initState();

    _bloc = findDep<VendorCarDetailsBloc>();

    _car = widget.car;

    _loadCustomIcons();
  }

  void _loadCustomIcons() async {
    _pickUpMarkerIcon =
        await getBitmapDescriptorFromAssetBytes(AppAssets.carPickUpMarker, 100);
    _dropOffMarkerIcon = await getBitmapDescriptorFromAssetBytes(
        AppAssets.carDropOffMarker, 100);

    _setMapMarkers();
  }

  void _setMapMarkers() {
    if (mounted) {
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId('pick-up-marker'),
          position:
              LatLng(_car.pickUpLocationLatitude, _car.pickUpLocationLongitude),
          icon: _pickUpMarkerIcon!,
        ));
        markers.add(Marker(
          markerId: const MarkerId('drop-off-marker'),
          position: LatLng(
              _car.dropOffLocationLatitude, _car.dropOffLocationLongitude),
          icon: _dropOffMarkerIcon!,
        ));
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _startDelivery() {
    _bloc.add(StartDelivery(carId: _car.id));

    /// flashing an event for start trip
    eventTracker(event: ButtonAnalyticIdentity.startTrip);
  }

  void _completeDelivery() {
    _bloc.add(CompleteDelivery(carId: _car.id));

    /// flashing an event for complete trip
    eventTracker(event: ButtonAnalyticIdentity.endTrip);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          translate.notification,
          style: appTextStyle.normalTSBasic.copyWith(
              color: AppColors.secondaryDarkGrayColor,
              fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: appTextStyle.middleTSBasic
              .copyWith(color: AppColors.secondaryDarkGrayColor),
        ),
        actions: [
          TextButton(
            child: Text(
              translate.done,
              style: appTextStyle.middleTSBasic
                  .copyWith(color: AppColors.primaryGrayColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  latLngBoundsMapPosition(LatLngBounds lngBounds,
      {double padding = 14.0}) async {
    await mapController
        .animateCamera(CameraUpdate.newLatLngBounds(lngBounds, padding));
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    double margins = 0.1013 * width;
    final appBar = AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryOrangeColor,
          statusBarIconBrightness: Brightness.light),
      toolbarHeight: 0,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top -
        margins;
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<VendorCarDetailsBloc, VendorCarDetailsState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is VendorCarDetailsUpdatedToDelivered) {
            _showDialog(translate.complete_trip_msg);
          } else if (state is VendorCarDetailsUpdatedToDelivering) {
            _showDialog(translate.start_trip_msg);
          } else if (state is VendorCarDetailsError) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          } else if (state is VendorCarDetailsLoaded &&
              state.latLngBounds != null) {
            /// focus the camera on the start and end points
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _car = state.car;
              if (mounted) setState(() {});
            });

            WidgetsBinding.instance.addPostFrameCallback((_) {
              latLngBoundsMapPosition(state.latLngBounds!);
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(_car.currentLocationLatitude,
                      _car.currentLocationLongitude),
                  zoom: AppConstants.initialCameraZoom,
                ),
                markers: markers,
                zoomControlsEnabled: false,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.space10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// car details
                      SlideInRight(
                        from: 800,
                        child: CarMapItemWidget(
                            car: _car, width: width, height: height * .28),
                      ),

                      if (_car.status == CarStatusType.pending.value)
                        SlideInUp(
                          from: 1000,
                          child: CustomElevatedButton(
                              onPressed: _startDelivery,
                              borderRadius: AppRadius.radius12,
                              backgroundColor: AppColors.green,
                              child: Text(
                                translate.accept_and_start_delivery,
                                style: appTextStyle.middleTSBasic
                                    .copyWith(color: AppColors.white),
                              )),
                        ),

                      if (_car.status == CarStatusType.delivering.value)
                        SlideInUp(
                          from: 1000,
                          child: SizedBox(
                            width: width,
                            child: CustomElevatedButton(
                                onPressed: _completeDelivery,
                                borderRadius: AppRadius.radius12,
                                backgroundColor: AppColors.green,
                                child: Text(
                                  translate.mark_as_delivered,
                                  style: appTextStyle.middleTSBasic
                                      .copyWith(color: AppColors.white),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (state is VendorCarDetailsLoading)
                const Center(
                  child: AppLoader(
                    iconColor: AppColors.primaryOrangeColor,
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
