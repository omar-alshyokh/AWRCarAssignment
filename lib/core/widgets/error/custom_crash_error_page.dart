import 'dart:async';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/analytics/central/analytics_central_impl.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_params_builder.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/core/widgets/common/restart_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomCrashErrorPage extends StatefulWidget {
  final FlutterErrorDetails errorDetails;

  const CustomCrashErrorPage({
    super.key,
    required this.errorDetails,
  });

  @override
  State<CustomCrashErrorPage> createState() => _CustomCrashErrorPageState();
}

class _CustomCrashErrorPageState extends State<CustomCrashErrorPage> {
  @override
  void initState() {
    super.initState();

    FirebaseCrashlytics.instance.recordError(
        widget.errorDetails.exception.toString(), widget.errorDetails.stack,
        reason:
            'App Crash: ${widget.errorDetails.summary.toString()} - library:${widget.errorDetails.library.toString()}',
        fatal: true);
    findDep<AnalyticsCentralImpl>().buttonViewTracker(
      event: ButtonAnalyticIdentity.crash,
      parameters: findDep<AnalyticsParamsBuilder>().appCrashParams(
        exception: widget.errorDetails.exception.toString(),
        library: widget.errorDetails.library.toString(),
        stack: widget.errorDetails.stack.toString(),
        summary: widget.errorDetails.summary.toString(),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashScreenTimer();
    });
  }

  _startSplashScreenTimer() {
    const duration = Duration(seconds: 3);
    return Timer(duration, _restartApp);
  }

  void _restartApp() {
    RestartWidget.restartApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        automaticallyImplyLeading: true,
        onBack: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      backgroundColor: AppColors.white,
      body: Container(
        width: DeviceUtils.getScaledWidth(context, 1.0),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.space36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Spacer(),
            Text(
              "Sometimes went wrong. \nLooks like there was an error. We will relaunch the app for you.",
              textAlign: TextAlign.center,
              style: appTextStyle.middleTSBasic,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
