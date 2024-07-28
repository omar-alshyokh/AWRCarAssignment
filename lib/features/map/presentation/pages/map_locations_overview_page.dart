import 'dart:typed_data';

import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/map/presentation/bloc/overview_mab/map_bloc.dart';
import 'package:car_tracking_app/features/map/presentation/widgets/map_car_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationsOverviewPage extends StatefulWidget {
  const MapLocationsOverviewPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapLocationsOverviewPageState();
}

class _MapLocationsOverviewPageState extends State<MapLocationsOverviewPage> {
  late GoogleMapController _mapController;
  int _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  late final MapBloc _mapBloc;

  Set<Marker> markers = {};
  List<Marker> markersTemp = [];

  bool createMarkersInProgress = true;

  bool _carListVisible = false;

  @override
  void initState() {
    super.initState();

    _mapBloc = MapBloc();
    _mapBloc.add(GetCarsLocationEvent());
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void createMarkersList(List<CarEntity> allLocations) async {
    markersTemp = [];
    for (int i = 0; i <= allLocations.length; i++) {
      final marker = await _createMarker(allLocations[i], i);
      markersTemp.add(marker);
      markers = markersTemp.toSet();
      if (mounted) setState(() {});
    }
  }

  Future<Marker> _createMarker(CarEntity car, int index) async {
    final Uint8List markerIcon = await _markerIcon(car.status);

    // creating a new MARKER
    final Marker marker = Marker(
        markerId: MarkerId(car.id),
        position:
        LatLng(car.currentLocationLatitude, car.currentLocationLongitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: car.name,
          snippet: '${translate.status}: ${_carStatusString(car.status)}',
        ),
        onTap: () {
          _onMarkerTap(index);
        });
    return marker;
  }

  Future<Uint8List> _markerIcon(int status) async {
    String imgPath = "";
    switch (status) {
      case 1: // Pending
        imgPath = AppAssets.carMarkerPending;
        break;
      case 2: // Delivering
        imgPath = AppAssets.carMarkerDelivering;
        break;
      case 3: // Delivered
        imgPath = AppAssets.carMarkerDelivered;
        break;
      default:
        imgPath = AppAssets.carMarkerUnknown;
    }
    Uint8List newMarker =
    await getBytesFromAsset(imgPath, 65); // size of custom image as marker;

    return newMarker;
  }

  void _moveCamera(LatLng position) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: AppConstants.initialCameraZoom),
      ),
    );
  }

  void _onMarkerTap(int index) async{
    if (mounted) {
      setState(() {
        _carListVisible = true;
      });
    }

   await Future.delayed(const Duration(microseconds: AppDurations.shortAnimationDuration));

    if(_pageController.hasClients){
      _pageController.animateToPage(
        index,
        duration:
        const Duration(milliseconds: AppDurations.shortAnimationDuration),
        curve: Curves.easeInOut,
      );
    }
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
        MediaQuery
            .of(context)
            .viewPadding
            .top -
        margins;

    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<MapBloc, MapState>(
        bloc: _mapBloc,
        listener: (context, state) {
          if (state is GetCarsLocationSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              createMarkersList(state.cars);
              createMarkersInProgress = false;
              if (mounted) setState(() {});
            });
          } else if (state is GetCarsLocationFailed) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCarsLocationSuccess) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.cars[_selectedIndex].currentLocationLatitude,
                      state.cars[_selectedIndex].currentLocationLongitude,
                    ),
                    zoom: AppConstants.initialCameraZoom,
                  ),
                  markers: markers.toSet(),
                  onTap: (_) {
                    if (mounted) {
                      setState(() {
                        _carListVisible = false;
                      });
                    }
                  },
                ),

                /// loading progress
                Visibility(
                    visible: createMarkersInProgress,
                    child: const Center(
                        child: AppLoader(
                          iconColor: AppColors.primaryOrangeColor,
                        ))),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: height * .3,
                  child: MapCarHorizontalList(
                    controller: _pageController,
                    cars: state.cars,
                    width: width,
                    height: height,
                    visible: _carListVisible,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                        _moveCamera(LatLng(
                          state.cars[index].currentLocationLatitude,
                          state.cars[index].currentLocationLongitude,
                        ));
                      });
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  String _carStatusString(int status) {
    switch (status) {
      case 1:
        return translate.pending;
      case 2:
        return translate.delivering;
      case 3:
        return translate.delivered;
      default:
        return translate.unknown;
    }
  }
}
