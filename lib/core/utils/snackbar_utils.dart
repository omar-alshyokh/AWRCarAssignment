import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_extensions.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:car_tracking_app/core/error/dio_error.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {
  SnackBarUtil._();

  static void showWarningAlert(
      {required BuildContext context,
      required String title,
      required String body}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: Colors.orangeAccent,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          reverseAnimationCurve: Curves.easeOut,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextStyle.normalTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    // Add some spacing between title and body
                    Text(
                      body,
                      style: appTextStyle.normalTSBasic.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     controller.dismiss();
              //   },
              //   icon: const Icon(
              //     Icons.close,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
        );
      },
    );
  }

  static void showErrorAlert({
    required BaseError error,
    required BuildContext context,
  }) {
    final String title;
    final String body;

    if (error is NetworkConnectionError) {
      title = translate.connection_error;
      body = translate.something_went_wrong_check_connection;
    } else {
      title = translate.unknown_error;
      body = translate.woops;
    }

    showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: Colors.red,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          reverseAnimationCurve: Curves.easeOut,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextStyle.normalTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      body,
                      style: appTextStyle.normalTSBasic.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     controller.dismiss();
              //   },
              //   icon: const Icon(
              //     Icons.close,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
      },
    );
  }

  static void showCustomFlash({
    required BuildContext context,
    required String title,
    required String body,
    required Widget? icon,
    String? actionTitle,
    VoidCallback? action,
    Color? backgroundColor,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 6),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: backgroundColor ?? AppColors.green,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          reverseAnimationCurve: Curves.easeOut,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextStyle.normalTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      body,
                      style: appTextStyle.normalTSBasic.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              if(actionTitle.itHasValue)
              ElevatedButton(
                onPressed: () {
                  if(action!=null) {
                      action();
                    }
                    controller.dismiss();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  actionTitle??"",
                  style: appTextStyle.smallTSBasic.copyWith(
                    color: Colors.black, // text color
                  ),
                ),
              ),
            ],
          ),
          icon: icon,
        );
      },
    );
  }
}
