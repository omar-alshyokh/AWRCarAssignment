import 'dart:async';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/map/data/datasource/location_datasource.dart';
import 'package:car_tracking_app/features/map/data/models/route_item_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationSimulationRepo {
  final LocationDatasource _locationDataSource;
  final PolylinePoints _polylinePoints;

  LocationSimulationRepo(this._locationDataSource, this._polylinePoints);

  Future<List<LatLng>> generateRoute(
      LatLng startLocation, LatLng endLocation) async {
    String routeKey =
        '${startLocation.latitude},${startLocation.longitude}-${endLocation.latitude},${endLocation.longitude}';

    final routeExist = await _locationDataSource.routeExists(key: routeKey);
    LoggerService()
        .logDebug("routeExist with key: $routeKey  exist= $routeExist");

    if (routeExist) {
      /// Retrieve from cache
      final localRoute =
          await _locationDataSource.getRoutesByKey(key: routeKey);
      if (localRoute.hasDataOnly) {
        LoggerService().logDebug("localRoute= ${localRoute.data.toString()}");

        return localRoute.data!.map((e) => e.toLatLng()).toList();
      }
    }

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: dotenv.env["googleApiKey"],
      request: PolylineRequest(
        origin: PointLatLng(startLocation.latitude, startLocation.longitude),
        destination: PointLatLng(endLocation.latitude, endLocation.longitude),
        mode: TravelMode.driving,
        wayPoints: [],
      ),
    );

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      /// Store in cache
      await _locationDataSource.setLocalRoutesByKey(
          key: routeKey,
          routes: polylineCoordinates
              .map((e) => RouteItemModel.fromLatLng(latlng: e))
              .toList());
    } else {
      throw Exception('Error generating route: ${result.errorMessage}');
    }

    return polylineCoordinates;
  }

  /// Simulate the movement of a car from [startLocation] to [endLocation]
  /// over a given [durationInSeconds].
  Stream<LatLng> simulateLocationWithoutRoute(
      LatLng startLocation, LatLng endLocation, int durationInSeconds) async* {
    const int totalSteps = 100;
    final int stepDuration = (durationInSeconds * 1000) ~/ totalSteps;

    double latStep =
        (endLocation.latitude - startLocation.latitude) / totalSteps;
    double lngStep =
        (endLocation.longitude - startLocation.longitude) / totalSteps;

    LatLng currentLocation = startLocation;
    for (int i = 0; i < totalSteps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));
      currentLocation = LatLng(
        currentLocation.latitude + latStep,
        currentLocation.longitude + lngStep,
      );

      yield currentLocation;

      if ((currentLocation.latitude >= endLocation.latitude && latStep > 0) ||
          (currentLocation.latitude <= endLocation.latitude && latStep < 0) ||
          (currentLocation.longitude >= endLocation.longitude && lngStep > 0) ||
          (currentLocation.longitude <= endLocation.longitude && lngStep < 0)) {
        break;
      }
    }
    yield endLocation;
  }

  Stream<LatLng> simulateLocation(
      List<LatLng> route, int durationInSeconds) async* {
    final int totalSteps = route.length;
    final int stepDuration = (durationInSeconds * 1000) ~/ totalSteps;

    for (int i = 0; i < totalSteps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));
      yield route[i];
    }
  }
}
