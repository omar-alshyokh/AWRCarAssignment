import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class LocationSimulationRepo {
  /// Simulate the movement of a car from [startLocation] to [endLocation]
  /// over a given [durationInSeconds].
  Stream<LatLng> simulateLocation(
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
}
