import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';


import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/helper/location_helper.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/map_navigation_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AppMapWidget extends StatefulWidget {
  const AppMapWidget({
    super.key,
    this.latLng,
    this.markers,
    this.locationName,
    this.onCameraMove,
    this.onMapCreated,
    this.onLocationSelected,
    this.compassEnabled = false,
    this.shouldGetLocationPermission = false,
    this.myLocationButtonEnabled = false,
    this.myLocationEnabled = false,
    this.mapToolbarEnabled = false,
    this.indoorViewEnabled = false,
    this.rotateGesturesEnabled = false,
    this.scrollGesturesEnabled = false,
    this.zoomControlsEnabled = false,
    this.zoomGesturesEnabled = false,
  });

  final AppLatLng? latLng;
  final bool compassEnabled;
  final String? locationName;
  final bool indoorViewEnabled;
  final bool mapToolbarEnabled;
  final bool myLocationEnabled;
  final bool zoomGesturesEnabled;
  final List<AppMarker>? markers;
  final bool zoomControlsEnabled;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool myLocationButtonEnabled;
  final bool shouldGetLocationPermission;
  final void Function(AppLatLng)? onLocationSelected;
  final void Function(AppCameraPosition position)? onCameraMove;
  final void Function(AppMapController controller)? onMapCreated;

  @override
  State<AppMapWidget> createState() => AppMapWidgetState();
}

class AppMapWidgetState extends State<AppMapWidget> {
  bool hasInitialized = false;
  String _mapStyle = '';
  //
  late LatLng _latLng;
  List<Marker> markers = [];

  BitmapDescriptor? _markerIcon;
  late CameraPosition _kInitialLocation;
  _AppGoogleMapController? controller;


  bool get isSelectionOn {
    return widget.onLocationSelected != null;
  }

  double get getZoom {
    return AppConstants.initialCameraZoom;
  }
  _getStyle() async {
    final String style =
    await AppUtils.getStringFromAsset(fileName: AppAssets.googleMapStyle);
    if (mounted) {
      setState(() {
        _mapStyle = style;
      });
    }
  }

  @override
  void didUpdateWidget(covariant AppMapWidget oldWidget) {
    final isListsEquals = listEquals(widget.markers, oldWidget.markers);
    final isEquals = oldWidget.latLng?.latitude == widget.latLng?.latitude &&
        oldWidget.latLng?.longitude == widget.latLng?.longitude;
    if (!isListsEquals || (!isEquals && widget.latLng != null)) {
      _updateMap();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initData();
      // Load the custom map style
      _getStyle();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    try {
      if (hasInitialized) {
        if (!widget.myLocationEnabled) {
          return _buildMap();
        }
        return FutureBuilder(
          future: LocationHelper.getLocation(),
          builder: (context, snapShot) {
            if (snapShot.hasData || !widget.shouldGetLocationPermission) {
              return _buildMap();
            }
            if (snapShot.hasError) {
              return Center(
                child: Text(
                  translate.location_permission_is_required,
                  style: appTextStyle.middleTSBasic.copyWith(
                    color: AppColors.black,
                  ),
                ),
              );
            }

            return const Center(child: AppLoader());
          },
        );
      }
      return const AppLoader();
    } catch (error, stack) {
      LoggerService().logError(error.toString(), stack);
      return Center(
        child: Text(
          translate.error_unexpected,
          style: appTextStyle.middleTSBasic.copyWith(
            color: AppColors.black,
          ),
        ),
      );
    }
  }

  Future<Marker> _createMarker() async {
    _markerIcon ??= (await getCustomIcon());
    return Marker(
      markerId: MarkerId(_latLng.toJson().toString()),
      position: _latLng,
      icon: _markerIcon!,
      onTap: isSelectionOn
          ? null
          : () {
              _direction(
                _latLng.latitude.toString(),
                _latLng.longitude.toString(),
                widget.locationName,
              );
            },
    );
  }

  void _direction(String latitude, String longitude, String? locationName) {
    AppBottomSheet.showAppModalBottomSheet(
      context,
      MapNavigationBottomSheet(
        onNavigate: () {
          AppUtils.launchNavigator(
            latitude,
            longitude,
            locationName: locationName,
          );
        },
      ),
    );
  }

  Future<void> initData() async {
    if (isSelectionOn) {
      if (widget.latLng != null) {
        _latLng = LatLng(widget.latLng!.latitude, widget.latLng!.longitude);
      } else {
        final temp = AppConstants.initialMapLocation;
        _latLng = LatLng(temp.latitude, temp.longitude);
      }
    } else {
      if (widget.latLng != null) {
        _latLng = LatLng(widget.latLng!.latitude, widget.latLng!.longitude);
      } else if (widget.markers != null && (widget.markers!.isNotEmpty)) {
        final appMarker = widget.markers!.first;

        _latLng = LatLng(appMarker.latitude, appMarker.longitude);
      } else {
        final temp = AppConstants.initialMapLocation;
        _latLng = LatLng(temp.latitude, temp.longitude);
      }
    }

    // if (!isSelectionOn)
    {
      if (widget.markers != null) {
        markers = (await convertMarkers(widget.markers!)).toList();
      } else {
        markers = [await _createMarker()];
      }
    }
    _moveCamera();

    if (mounted) {
      setState(() {
        hasInitialized = true;
      });
    }
  }

  void _updateMap() async {
    markers.clear();

    // Check if there are new markers to add
    if (widget.markers != null) {
      // Convert your AppMarkers to Google Map Markers and add them to the markers list
      markers = (await convertMarkers(widget.markers!)).toList();
      final appMarker = widget.markers!.first;

      _latLng = LatLng(appMarker.latitude, appMarker.longitude);
    } else if (widget.latLng != null) {
      // If there are no markers in the widget, just add a default one or handle as necessary
      if (widget.latLng != null) {
        _latLng = LatLng(widget.latLng!.latitude, widget.latLng!.longitude);
      }
      markers = [await _createMarker()];
    }

    _moveCamera();
  }

  void _moveCamera() {
    _kInitialLocation = CameraPosition(
      target: _latLng,
      zoom: AppConstants.initialCameraZoom,
    );
  }

  Widget _buildMap() {
    return Column(
      children: [
        Flexible(
          child: GoogleMap(
            onTap: isSelectionOn
                ? (newLatLng) {
                    _latLng = newLatLng;
                    if (mounted) setState(() {});
                    widget.onLocationSelected!(
                      AppLatLng(
                        newLatLng.latitude,
                        newLatLng.longitude,
                      ),
                    );
                  }
                : null,
            onCameraMove: (cameraMove) {
              if (widget.onCameraMove != null) {
                widget.onCameraMove!(
                  AppCameraPosition.fromCameraMove(cameraMove),
                );
              }
            },
            style: _mapStyle,
            onMapCreated: (GoogleMapController controller) {
              this.controller = _AppGoogleMapController(controller);
              if (widget.onMapCreated != null) {
                widget.onMapCreated!(this.controller!);
              }
            },
            buildingsEnabled: false,
            compassEnabled: widget.compassEnabled,
            initialCameraPosition: _kInitialLocation,
            indoorViewEnabled: widget.indoorViewEnabled,
            mapToolbarEnabled: widget.mapToolbarEnabled,
            myLocationEnabled: widget.myLocationEnabled,
            zoomGesturesEnabled: widget.zoomGesturesEnabled,
            zoomControlsEnabled: widget.zoomControlsEnabled,
            myLocationButtonEnabled: widget.myLocationButtonEnabled,
            scrollGesturesEnabled: widget.scrollGesturesEnabled,
            markers: markers.toSet(),
          ),
        ),
      ],
    );
  }

  Future<Set<Marker>> convertMarkers(List<AppMarker> markers) async {
    final temp = <Marker>{};

    final icon = await getCustomIcon();
    for (var marker in markers) {
      final res = Marker(
        consumeTapEvents: false,
        markerId: MarkerId('${marker.latitude},${marker.longitude}'),
        position: LatLng(marker.latitude, marker.longitude),
        icon: icon!,
        // Use the generated icon from text
        onTap: marker.onTap,
      );
      temp.add(res);
    }
    return temp;
  }

  Future<BitmapDescriptor?> getCustomIcon() async {
    try {
      final icon = await getBitmapDescriptorFromAssetBytes(
        AppAssets.carMarker,
        165,
      );
      return icon;
    } catch (error, stack) {
      LoggerService().logError(error.toString(), stack);
    }
    return null;
  }
}

Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
  String path,
  int width,
) async {
  final Uint8List imageData = await getBytesFromAsset(path, width);
  // ignore: deprecated_member_use
  return BitmapDescriptor.fromBytes(imageData);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);

  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  Uint8List byteData =
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
  return byteData;
}

class AppMarker {
  final String id;
  final double latitude;
  final double longitude;
  final Function()? onTap;

  AppMarker(
    this.id,
    this.latitude,
    this.longitude, {
    this.onTap,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppMarker &&
        other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ;
  }

  @override
  String toString() {
    return "$AppMarker ("
        "id: $id, "
        "latitude: $latitude, "
        "longitude: $longitude, "
        ")";
  }
}

abstract class AppMapController {
  void moveCamera(double latitude, double longitude, double zoom);
}

class _AppGoogleMapController extends AppMapController {
  final GoogleMapController _controller;

  _AppGoogleMapController(this._controller);

  @override
  void moveCamera(double latitude, double longitude, double zoom) {
    _controller.moveCamera(
      CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), zoom),
    );
  }
}

class AppCameraPosition {
  const AppCameraPosition({
    this.bearing = 0.0,
    required this.target,
    this.tilt = 0.0,
    this.zoom = 0.0,
  });

  factory AppCameraPosition.fromCameraMove(CameraPosition cameraMove) {
    return AppCameraPosition(
      target: AppLatLng.fromLatLng(cameraMove.target),
      zoom: cameraMove.zoom,
      tilt: cameraMove.tilt,
    );
  }

  final double bearing;

  final AppLatLng target;

  final double tilt;

  final double zoom;
}

class AppLatLng {
  const AppLatLng(double latitude, double longitude)
      : latitude =
            latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        // Avoids normalization if possible to prevent unnecessary loss of precision
        longitude = longitude >= -180 && longitude < 180
            ? longitude
            : (longitude + 180.0) % 360.0 - 180.0;

  /// The latitude in degrees between -90.0 and 90.0, both inclusive.
  final double latitude;

  /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
  final double longitude;

  factory AppLatLng.fromLatLng(LatLng target) {
    return AppLatLng(target.latitude, target.longitude);
  }
}

/// Creates an image from the given widget by first spinning up a element and render tree,
/// wait [waitToRender] to render the widget that take time like network and asset images

/// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
/// By default Value of  [imageSize] and [logicalSize] will be calculate from the app main window

Future<Uint8List> createImageFromWidget(Widget widget,
    {Size? logicalSize,
    required Duration waitToRender,
    Size? imageSize}) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
  final view = ui.PlatformDispatcher.instance.views.first;
  logicalSize ??= view.physicalSize / view.devicePixelRatio;
  imageSize ??= view.physicalSize;

  // assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  final RenderView renderView = RenderView(
    view: view,
    child: RenderPositionedBox(
        alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      logicalConstraints: BoxConstraints(
        maxHeight: logicalSize.height,
        maxWidth: logicalSize.width,
      ),
      devicePixelRatio: 1.0,
    ),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement =
      RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  await Future.delayed(waitToRender);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(
      pixelRatio: imageSize.width / logicalSize.width);
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
