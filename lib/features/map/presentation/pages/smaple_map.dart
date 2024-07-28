import 'dart:async';

import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    // Load the custom map style
    _getStyle();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Google Map Style'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(25.276987, 55.296249), // Coordinates for Dubai
          zoom: 12, // Zoom level to focus on Dubai
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        style: _mapStyle,
      ),
    );
  }
}
