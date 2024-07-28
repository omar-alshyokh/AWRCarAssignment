import 'package:car_tracking_app/features/app/presentation/pages/main_page.dart';
import 'package:car_tracking_app/features/car/presentation/pages/add_car_page.dart';
import 'package:car_tracking_app/features/map/presentation/pages/map_locations_overview_page.dart';
import 'package:car_tracking_app/features/map/presentation/pages/smaple_map.dart';
import 'package:car_tracking_app/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking_app/features/auth/presentation/pages/login_page.dart';
import 'package:car_tracking_app/features/home/presentation/pages/home_page.dart';
import 'package:car_tracking_app/features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String mainPage = "/mainPage";
  static const String home = "/home";
  static const String settingsPage = "/settingsPage";
  static const String login = "/auth/login";
  static const String mapSample = "/map/mapSample";
  static const String mapLocationsOverviewPage =
      "/map/mapLocationsOverviewPage";

  // static const String carListPage = "/car/carListPage";
  static const String addCarPage = "/car/addCarPage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SplashPage());
      case home:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => const HomePage());
      case mainPage:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => const MainPage());
      case login:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => const LoginPage());

      case settingsPage:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SettingsPage());

      case mapLocationsOverviewPage:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const MapLocationsOverviewPage());

      case mapSample:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => const MapSample());
      // case carListPage:
      // return PageRouteBuilder(
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => const CarListPage());

      case addCarPage:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const AddCarPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
