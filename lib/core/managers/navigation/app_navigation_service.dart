import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppNavigationService {

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
