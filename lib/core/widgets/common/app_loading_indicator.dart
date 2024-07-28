// Flutter imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:

enum AppLoaderSize {
  vMicroscopic,
  microscopic,
  tiny,
  small,
  normal,
}

class AppLoader extends StatelessWidget {
  final AppLoaderSize size;
  final Color? iconColor;

  const AppLoader({
    super.key,
    this.size = AppLoaderSize.small,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    double size = 40;
    if (this.size == AppLoaderSize.small) size = 40;
    if (this.size == AppLoaderSize.tiny) size = 24;
    if (this.size == AppLoaderSize.microscopic) size = 18;
    if (this.size == AppLoaderSize.vMicroscopic) size = 14;
    return Center(
      child: SpinKitFadingFour(
        size: size,
        color: iconColor ?? AppColors.primaryOrangeColor,
      ),
    );
  }
}
