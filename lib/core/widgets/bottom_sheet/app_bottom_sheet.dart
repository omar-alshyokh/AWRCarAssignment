// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'general_bottom_sheet.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static Future<T?> showAppModalBottomSheet<T>(
    BuildContext context,
    Widget child, {
    bool unFocusKeyboard = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool useSafeArea = false,
    double? height,
    bool useFixedHeight = true,
  }) async {
    if (unFocusKeyboard) AppUtils.unFocus(context);
    final h = useFixedHeight ? DeviceUtils.getScaledHeight(context, .96) : null;
    return showModalBottomSheet(
      context: context,
      elevation: 10,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useSafeArea: useSafeArea,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppRadius.bottomSheetBorderRadius,
          ),
        ),
      ),
      isScrollControlled: isScrollControlled,
      builder: (context) => GeneralBottomSheet(
        height: height ?? h,
        child: child,
      ),
    );
  }

  static Future<T?> showBlurBottomSheet<T>(
    BuildContext context,
    Widget child, {
    bool unFocusKeyboard = true,
    double height = 800,
  }) async {
    if (unFocusKeyboard) AppUtils.unFocus(context);
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GeneralBottomSheet(
        height: height,
        child: child,
      ),
    );
  }
}
