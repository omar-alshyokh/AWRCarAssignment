// Project imports
import 'package:car_tracking_app/core/service/logger_service.dart';

// Package imports:
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


abstract class LocationHelper {
  static Future<Null>? getOnLocationError(Object error, StackTrace stack) {
    LoggerService().logError(error.toString(), stack);
    return null;
  }

  LocationHelper._();



  static Future<Position> getLocation() async {
    // Check if location services are enabled.
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
          ExceptionLocationService(
            LocationServiceState.deniedForever,
            message: 'Location permissions are permanently denied.',
          ),
        );
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
          ExceptionLocationService(
            LocationServiceState.denied,
            message: 'Location permissions are denied.',
          ),
        );
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position? response = await Geolocator.getLastKnownPosition();
    if (response != null) {
      return response;
    }
    response = await Geolocator.getCurrentPosition();
    getAddressFromLatLng(response.latitude, response.longitude);

    return response;
  }

  static Future<Placemark?> getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      LoggerService().logDebug('placeMarks is empty');
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        LoggerService().logDebug("placeMarks result ${place.toJson()}");
        return place;
      }
    } catch (error, stack) {
      LoggerService().logError(error.toString(), stack);
      LoggerService().logDebug(error.toString());
      LoggerService().logDebug(stack.toString());
    }
    return null;
  }

  static String getLoc(Placemark? place) {
    String location = '';
    try {
      if (place != null) {
        location = place.street ?? '';
        if (location.isEmpty) {
          location = "${place.locality}, ${place.country}";
        }
        if (place.subLocality != null &&
            !location.contains(place.subLocality!)) {
          location += ', ${place.subLocality}';
        }
        if (place.country != null && !location.contains(place.country!)) {
          location += ', ${place.country}';
        }
      }
    } catch (error, stack) {
      LoggerService().logError(error.toString(), stack);
      LoggerService().logDebug(error.toString());
      LoggerService().logDebug(stack.toString());
    }
    return location;
  }
}

enum LocationServiceState {
  serviceNotEnabled,
  deniedForever,
  denied,
  none,
}

class ExceptionLocationService implements Exception {
  final LocationServiceState state;
  final String? message;

  ExceptionLocationService(this.state, {this.message});
}
