// // ignore_for_file: deprecated_member_use
//
// import 'dart:typed_data';
// import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
// import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:collection/collection.dart';
//
// mixin MixinGoogleMap<T extends BaseAppStatefulWidget> on BaseAppState<T> {
//   GoogleMapController? controller;
//
//   LatLng? center;
//
//   Set<Marker>? markers;
//   List<Marker> markersTemp = [];
//
//   List<CarEntity> allLocations = <CarEntity>[];
//   bool createMarkersInProgress = true;
//
//   Function(LatLng? centerPoint, LatLngBounds? lngBounds, int locationsCount)?onCreateMarkFinish;
//   bool? showNavigationPin;
//
//   /// default cord to focus the camera on it at first time
//   double? refLatitude, refLongitude;
//
//   @override
//   void initState() {
//     super.initState();
//     _assetsHelper = findDep<AssetsHelper>();
//     defaultUserLocation();
//   }
//
//   void defaultUserLocation() {
//     try {
//       final userPosition = BlocProvider.of<ProfileCubit>(context).locationData;
//       if (userPosition != null) {
//         refLatitude = userPosition.latitude;
//         refLongitude = userPosition.longitude;
//       } else {
//         /// center of Palm
//         refLatitude = 25.1136;
//         refLongitude = 55.1386;
//       }
//     } catch (e) {
//       appPrint("Error with defaultUserLocation ${e.toString()}");
//     }
//   }
//
//   void createMarkersList(List<POILookupEntity> allLocations,
//       {LatLng? centerPoint, LatLngBounds? lngBounds}) async {
//     var seen = <String>{};
//
//     List<POILookupEntity> uniqueList = allLocations
//         .where((loc) => seen.add('${loc.lnglat[1]},${loc.lnglat[0]}'))
//         .toList();
//
//     markersTemp = [];
//     for (var element in uniqueList) {
//       final marker = await _createMarker(element, 0);
//       markersTemp.add(marker);
//       markers = markersTemp.toSet();
//       if (mounted) setState(() {});
//     }
//
//     // Trigger the callback to notify the host page.
//     if (onCreateMarkFinish != null) {
//       appPrint("markersTemp.length ${uniqueList.length}");
//       onCreateMarkFinish!(centerPoint, lngBounds, uniqueList.length);
//     }
//   }
//
//   List<int> findCatchableIdsByLocation(List<double>? targetLngLat) {
//     Set<int> catchableIds = {};
//
//     if (targetLngLat != null &&
//         targetLngLat.isNotEmpty &&
//         targetLngLat.length >= 2) {
//       List<POILookupEntity> closeScreens = findByLocation(targetLngLat);
//
//       for (var element in closeScreens) {
//         if (element.catchableIds != null) {
//           catchableIds.addAll(element.catchableIds!);
//         }
//       }
//     }
//
//     return catchableIds.toList();
//   }
//
//   List<POILookupEntity> findByLocation(List<double> targetLngLat) {
//     double threshold = 0.0001; // Example threshold for comparison
//     return allLocations.where((entity) {
//       // Compare lnglat values with a threshold to allow for minor differences
//       bool isCloseEnough =
//           (entity.lnglat[0] - targetLngLat[0]).abs() <= threshold &&
//               (entity.lnglat[1] - targetLngLat[1]).abs() <= threshold;
//       return isCloseEnough;
//     }).toList();
//   }
//
//   Future<Marker> _createMarker(
//       POILookupEntity locationLookup, int count) async {
//     /*var request = await http.get(brand.imageUrl);
//     var bytes = await request.bodyBytes;*/
//
//     /// circle with campaigns number
//     // final Uint8List? markerIcon = await _assetsHelper.getBytesFromCanvas(
//     //     64, 64, count, false);
//
//     final Uint8List markerIcon = await _markerIcon(false);
//
//     // creating a new MARKER
//     final Marker marker = Marker(
//         markerId: MarkerId(locationLookup.uuid),
//         position: LatLng(locationLookup.lnglat[1], locationLookup.lnglat[0]),
//         // icon: BitmapDescriptor.fromBytes(bytes.buffer.asUint8List(),),
//         icon: BitmapDescriptor.fromBytes(markerIcon),
//         onTap: () {
//           _onMarkPressed(locationLookup, count);
//         });
//     return marker;
//   }
//
//   Future<Uint8List> _markerIcon(bool? isSelected) async {
//     String imgPath = "";
//     if (isSelected == true) {
//       imgPath = AppAssets.mapPinSelected;
//     } else {
//       imgPath = AppAssets.mapPin;
//     }
//     Uint8List newMarker = await _assetsHelper.getBytesFromAsset(
//         path: imgPath,
//         width: isSelected == true ? 90 : 60); // size of custom image as marker;
//
//     return newMarker;
//   }
//
//   _onMarkPressed(POILookupEntity? locationLookup, count) async {
//     if (mounted) {
//       Marker? prevElement;
//
//       /// check if we was tapping on another item before
//       if (previousSelected != null) {
//         prevElement = markers?.firstWhereOrNull(
//             (element) => element.markerId == MarkerId(previousSelected!.uuid));
//         if (prevElement != null) {
//           // final Uint8List? prevMarkerIcon =
//           //     await _assetsHelper.getBytesFromCanvas(
//           //         64, 64, count, false);
//           final Uint8List prevMarkerIcon = await _markerIcon(null);
//           Marker prevMarker = Marker(
//               markerId: prevElement.markerId,
//               position: prevElement.position,
//               icon: BitmapDescriptor.fromBytes(prevMarkerIcon),
//               onTap: prevElement.onTap);
//           markers?.removeWhere(
//               (element) => element.markerId == prevElement!.markerId);
//           markers?.add(prevMarker);
//
//           /// remove navigation pin marker
//           if (showNavigationPin != null && showNavigationPin == true) {
//             markers?.removeWhere((element) =>
//                 element.markerId.value == AppConstants.navigationPinMarkerId);
//           }
//         }
//       }
//
//       if (locationLookup != null) {
//         // final Uint8List? markerIcon = await _assetsHelper.getBytesFromCanvas(
//         //     120, 120, count, true);
//         final Uint8List markerIcon = await _markerIcon(true);
//
//         Marker? element = markers?.firstWhereOrNull(
//             (element) => element.markerId == MarkerId(locationLookup.uuid));
//         if (element != null) {
//           Marker marker = Marker(
//               markerId: element.markerId,
//               position: element.position,
//               icon: BitmapDescriptor.fromBytes(markerIcon),
//               onTap: element.onTap,
//               zIndex: 100);
//           markers?.removeWhere(
//               (element) => element.markerId == MarkerId(locationLookup.uuid));
//           markers?.add(marker);
//         }
//
//         /// add navigation icon
//         if (showNavigationPin != null && showNavigationPin == true) {
//           final navigationPinIcon = await _assetsHelper.getBytesFromAsset(
//               path: AppAssets.navigationPin, width: 300);
//           LatLng navigationPinPosition =
//               LatLng(locationLookup.lnglat[1], locationLookup.lnglat[0]);
//           var navigateButtonMarker = Marker(
//             zIndex: 1000,
//             markerId: const MarkerId(AppConstants.navigationPinMarkerId),
//             position: navigationPinPosition,
//             onTap: () {
//               AppUtils.launchNavigator(
//                 navigationPinPosition.latitude.toString(),
//                 navigationPinPosition.longitude.toString(),
//                 locationName: locationLookup.clippedName,
//               );
//             },
//             icon: BitmapDescriptor.fromBytes(navigationPinIcon),
//             anchor: const Offset(0.5, 1.6),
//           );
//           markers?.add(navigateButtonMarker);
//         }
//       }
//
//       // Trigger the callback to notify the host page.
//       if (onMarkerStatusUpdated != null) {
//         onMarkerStatusUpdated!(locationLookup);
//       }
//       // finally set the new location as the previous selected item to check it when another new item pressed
//       if (mounted) {
//         setState(() {
//           previousSelected = locationLookup;
//         });
//       }
//     }
//   }
//
//   Widget mapWidget({double? latitude, double? longitude}) {
//     CameraPosition? initialCenter;
//     if (latitude != null && longitude != null) {
//       initialCenter =
//           CameraPosition(target: LatLng(latitude, longitude), zoom: 13);
//     }
//     return CatchMapWidget(
//       onMapCreated: (newController) {
//         if (mounted) {
//           setState(() {
//             controller = newController;
//           });
//         }
//       },
//       onCameraMove: (position) {},
//       onCameraIdle: () {},
//       initialCameraPosition: initialCenter,
//       center: center,
//       markers: markers,
//       myLocationButtonEnabled: false,
//       myLocationEnabled: true,
//       zoomControlsEnabled: false,
//       onMapTap: (position) {
//         _onMarkPressed(null, 0);
//       },
//     );
//   }
//
//   void updateMapPosition(LatLng newLatLng, {double zoom = 14.0}) async {
//     if (controller != null) {
//       await controller!.animateCamera(CameraUpdate.newLatLngZoom(
//           LatLng(newLatLng.latitude, newLatLng.longitude), zoom));
//     }
//   }
//
//   void latLngBoundsMapPosition(LatLngBounds lngBounds,
//       {double padding = 14.0}) async {
//     if (controller != null) {
//       await controller!
//           .animateCamera(CameraUpdate.newLatLngBounds(lngBounds, padding));
//     }
//   }
//
//   Widget currentLocationIcon({required double bottomPositioned}) {
//     return AnimatedPositionedDirectional(
//       end: 23,
//       bottom: bottomPositioned,
//       duration: const Duration(milliseconds: 500),
//       child: RoundedShadowButton(
//         onPressed: _moveToMyLocation,
//         shadowColor: AppColors.blue900.withOpacity(0.2),
//         spreadRadius: 1.0,
//         width: 42,
//         height: 42,
//         borderRadius: AppRadius.radius10,
//         withBorder: true,
//         borderColor: AppColors.backGrey,
//         borderWidth: 2.0,
//         color: AppColors.white800,
//         child: const Center(child: Icon(AppIcons.mapLocationBtn, size: 32)),
//       ),
//     );
//   }
//
//   void _moveToMyLocation() async {
//     try {
//       bool serviceEnabled;
//       LocationPermission permission;
//
//       // Test if location services are enabled.
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         // Location services are not enabled don't continue
//         // accessing the position and request users of the
//         // App to enable the location services.
//         return Future.error('Location services are disabled.');
//       }
//
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           return Future.error('Location permissions are denied');
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         // Permissions are denied forever, handle appropriately.
//         return Future.error(
//             'Location permissions are permanently denied, we cannot request permissions.');
//       }
//       Position pos = await Geolocator.getCurrentPosition();
//       updateMapPosition(LatLng(pos.latitude, pos.longitude), zoom: 15.0);
//       eventTracker(
//           event: ButtonAnalyticIdentity.currentLocation,
//           parameters: analyticsParam.locationParamParam(locationData: pos));
//     } catch (e, s) {
//       LoggerService().logError(e.toString(), e, s);
//     }
//   }
//
//   int getScreenLength() {
//     if (previousSelected != null) {
//       return allLocations
//           .where((element) =>
//               element.lnglat[0] == previousSelected?.lnglat[0] &&
//               element.lnglat[1] == previousSelected?.lnglat[1])
//           .length;
//     }
//     return 0;
//   }
//
//   void updateReminders(Campaign updatedCampaign) {
//     findDep<ExploreCubit>().updateCampaignReminder(updatedCampaign);
//     if (mounted) {
//       setState(() {
//         updatedCampaign = updatedCampaign;
//       });
//     }
//   }
// }
