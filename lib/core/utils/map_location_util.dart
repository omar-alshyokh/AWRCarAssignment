import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Helper class for map related operations.
///
class MapLocationUtil {

  MapLocationUtil._();

  static double calculateBearing(LatLng start, LatLng end) {
    final lat1 = degreesToRadians(start.latitude);
    final lon1 = degreesToRadians(start.longitude);
    final lat2 = degreesToRadians(end.latitude);
    final lon2 = degreesToRadians(end.longitude);

    final dLon = lon2 - lon1;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final bearing = math.atan2(y, x);

    return (radiansToDegrees(bearing) + 360) % 360;
  }

  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  static double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }
}
