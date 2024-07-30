
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' as io;

class AppBuildDetails {
  static Future<Map<String, String>> toMap() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    final osName = io.Platform.operatingSystem;
    final String osVersion;
    final String deviceName;
    if (io.Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      osVersion = androidInfo.version.release;
      deviceName = androidInfo.model;
    } else if (io.Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.model;
      osVersion = iosInfo.systemVersion;
    } else {
      deviceName = '';
      osVersion = '';
    }
    return {
      'apn': 'AWRCarTracking',
      'apv': '$appVersion.$buildNumber',
      'dvn': deviceName,
      'osn': osName,
      'osv': osVersion,
    };
  }

  static Future<String> currentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
    return appVersion;
  }
}
