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

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SplashPage> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: AppDurations.splashAnimationDuration),
      vsync: this,
    );

    _startSplashScreenTimer(5);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: FadeIn(
          duration: const Duration(
              milliseconds: AppDurations.splashAnimationDuration),
          delay: const Duration(
              milliseconds: AppDurations.splashAnimationDelay),
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
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
