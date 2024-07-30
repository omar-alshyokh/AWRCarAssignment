import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:flutter/material.dart';

class AppRotatedBoxLanguage extends StatelessWidget {
  const AppRotatedBoxLanguage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: appLanguage == "ar" ? 270 : 0,
      child: child,
    );
  }
}
