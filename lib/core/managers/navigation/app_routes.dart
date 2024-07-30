import 'package:car_tracking_app/core/managers/navigation/fadel_route.dart';
import 'package:car_tracking_app/core/managers/navigation/slide_route.dart';
import 'package:car_tracking_app/features/app/presentation/pages/main_root_page.dart';
import 'package:car_tracking_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:car_tracking_app/features/auth/presentation/pages/vendor_signup_page.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/pages/add_car_page.dart';
import 'package:car_tracking_app/features/car/presentation/pages/car_details_page.dart';
import 'package:car_tracking_app/features/map/presentation/pages/map_locations_overview_page.dart';
import 'package:car_tracking_app/features/settings/presentation/pages/settings_page.dart';
import 'package:car_tracking_app/features/vendor/presentation/pages/vendor_car_details_page.dart';
import 'package:car_tracking_app/features/vendor/presentation/pages/vendor_car_list_page.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking_app/features/auth/presentation/pages/auth_intro_page.dart';
import 'package:car_tracking_app/features/home/presentation/pages/home_page.dart';
import 'package:car_tracking_app/features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String mainPage = "/mainPage";
  static const String home = "/home";
  static const String settingsPage = "/settingsPage";
  static const String authIntroPage = "/auth/authIntroPage";
  static const String adminLoginPage = "/auth/adminLoginPage";
  static const String vendorSignUpPage = "/auth/vendorSignUpPage";
  static const String mapSample = "/map/mapSample";
  static const String mapLocationsOverviewPage =
      "/map/mapLocationsOverviewPage";

  static const String carDetailsPage = "/car/carDetailsPage";
  static const String addCarPage = "/car/addCarPage";

  static const String vendorCarListPage = "/vendor/vendorCarListPage";
  static const String vendorCarDetailsPage = "/vendor/vendorCarDetailsPage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      ///  =================       Core Pages Here     =================
      case splash:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SplashPage());

      ///  =================       Auth Pages Here     =================
      case authIntroPage:
        return FadeRoute(settings: settings, page: const AuthIntroPage());

      case adminLoginPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const AdminLoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 333),
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );

      case vendorSignUpPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const VendorSignUpPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 333),
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );

      ///  =================       Admin Pages Here     =================

      case home:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => const HomePage());
      case mainPage:
        return FadeRoute(settings: settings, page: const MainRootPage());

      case settingsPage:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SettingsPage());

      case mapLocationsOverviewPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const MapLocationsOverviewPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 333),
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );

      case addCarPage:
        return FadeRoute(settings: settings, page: const AddCarPage());

      case carDetailsPage:
        final args = settings.arguments;
        assert(args is CarEntity,
            'This route requires argument car of type CarEntity.');

        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) =>
                CarDetailsPage(car: args as CarEntity));

      ///  =================       Vendor Pages Here     =================

      case vendorCarListPage:
        return FadeRoute(settings: settings, page: const VendorCarListPage());

      case vendorCarDetailsPage:
        final args = settings.arguments;
        assert(args is CarEntity,
            'This route requires argument car of type CarEntity.');

        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) =>
                VendorCarDetailsPage(car: args as CarEntity));
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
