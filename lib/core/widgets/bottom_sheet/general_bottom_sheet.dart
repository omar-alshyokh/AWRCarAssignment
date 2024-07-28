// Flutter imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:

class GeneralBottomSheet extends StatelessWidget {
  const GeneralBottomSheet({
    super.key,
    required this.height,
    required this.child,
  });

  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: height != null ? BoxConstraints(maxHeight: height!) : null,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppRadius.bottomSheetBorderRadius,
          ),
        ),
        color: AppColors.white,
      ),
      child: child,
    );
  }
}
