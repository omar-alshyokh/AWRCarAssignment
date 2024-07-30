import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _startSplashScreenTimer(5);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
          duration: const Duration(
              milliseconds: AppDurations.splashAnimationDuration),
          delay:
              const Duration(milliseconds: AppDurations.splashAnimationDelay),
          child: Image.asset(
            AppAssets.appLogo,
          ),
        ),
      ),
    );
  }

  _startSplashScreenTimer(int milliseconds) async {
    final duration = Duration(seconds: milliseconds);
    return Timer(duration, _navigation);
  }

  _navigation() async {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.authIntroPage, (route) => false);
    }
  }
}
