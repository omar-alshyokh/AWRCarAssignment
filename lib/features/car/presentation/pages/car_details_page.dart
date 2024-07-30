import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/constants.dart';

import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/title_section_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/bloc/car_bloc.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_main_info_widget.dart';
import 'package:car_tracking_app/features/map/presentation/widgets/car_live_tracking_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarDetailsPage extends BaseAppStatefulWidget {
  final CarEntity car;

  const CarDetailsPage({super.key, required this.car});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() =>
      _CarDetailsPageState();
}

class _CarDetailsPageState extends BaseAppState<CarDetailsPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  BitmapDescriptor? _pickUpMarkerIcon;
  BitmapDescriptor? _dropOffMarkerIcon;

  // BitmapDescriptor? _currentLocationMarkerIcon;
  late final CarBloc carBloc;
  late CarEntity _car;

  @override
  void initState() {
    super.initState();
    carBloc = findDep<CarBloc>();
    _car = widget.car;

    carBloc.add(LoadCarDetails(carId: _car.id));

    _loadCustomIcons();
  }

  void _loadCustomIcons() async {
    _pickUpMarkerIcon =
        await getBitmapDescriptorFromAssetBytes(AppAssets.carPickUpMarker, 100);
    _dropOffMarkerIcon = await getBitmapDescriptorFromAssetBytes(
        AppAssets.carDropOffMarker, 100);

    // _currentLocationMarkerIcon = await getBitmapDescriptorFromAssetBytes(
    //     AppAssets.carMarker, 100);

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
        // markers.add(Marker(
        //   markerId: const MarkerId('current-off-marker'),
        //   position: LatLng(
        //       _car.currentLocationLatitude, _car.currentLocationLongitude),
        //   icon: _currentLocationMarkerIcon!,
        // ));
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    double margins = 0.1013 * width;
    final appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: _car.statusColor,
          statusBarIconBrightness: Brightness.dark),
      toolbarHeight: 0,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top -
        margins;
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<CarBloc, CarState>(
        bloc: carBloc,
        listener: (context, state) {
          if (state is CarDetailsFailed) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          } else if (state is CarDetailsLoaded) {
            /// focus the camera on the start and end points
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _car = state.car;
              if (mounted) setState(() {});
            });

            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   latLngBoundsMapPosition(state.latLngBounds!);
            // });
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                flexibleSpace: Hero(
                  tag: '${_car.imageUrl!}${_car.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: AppDurations.shortAnimationDuration),
                      color: AppColors.white,
                      child: Image.asset(
                        _car.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                backgroundColor: AppColors.transparent,
                foregroundColor: AppColors.transparent,

              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppDimens.space16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    /// car name
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: _car.name,
                        style: appTextStyle.normalTSBasic.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: " (${_car.modelYear})",
                              style: appTextStyle.normalTSBasic.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    _buildMap(car: _car, width: width, height: height),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    _buildCarDetails(car: _car, width: width, height: height),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCarDetails(
      {required CarEntity car, required double width, required double height}) {
    return TitleSectionWidget(
      title: translate.car_main_info,
      child: SlideInRight(
        from: 800,
        child: CarMainInfoWidget(car: _car, width: width, height: height * .28),
      ),
    );
  }

  Widget _buildMap(
      {required CarEntity car, required double width, required double height}) {
    double mapHeight = height * 0.38;

    return TitleSectionWidget(
      title: translate.car_locations_details,
      child: Container(
        height: mapHeight,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.radius12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(car.currentLocationLatitude,
                      car.currentLocationLongitude),
                  zoom: 12.0,
                ),
                markers: markers,
                zoomControlsEnabled: false,
              ),
              if (_car.status == CarStatusType.delivering.value)
                AppInkWellWidget(
                  onTap: () {
                    /// flashing an event for displaying the live tracking location
                    eventTracker(event: ButtonAnalyticIdentity.showLiveLocation);
                    AppBottomSheet.showAppModalBottomSheet(
                      context,
                      CarLiveTrackingSheet(car: car),
                      enableDrag: false,
                    );
                  },
                  child: Container(
                    color: AppColors.primaryGrayColor.withOpacity(.5),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppRadius.radius12),
                            color: AppColors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.space16,
                            vertical: AppDimens.space8),
                        child: Text(
                          translate.tap_to_see_car_live_location,
                          style: appTextStyle.smallTSBasic
                              .copyWith(color: AppColors.black),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    carBloc.close();
    mapController.dispose();
    super.dispose();
  }
}
