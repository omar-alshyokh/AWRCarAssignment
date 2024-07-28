// Flutter imports:
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:

/// General clickable widget used across all the application based on [InkWell]
/// material defined widget.
class AppInkWellWidget extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onLongPress;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? splashAppInkWellColor;

  const AppInkWellWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.splashAppInkWellColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: splashAppInkWellColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        splashColor: splashAppInkWellColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.radius12),
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}
