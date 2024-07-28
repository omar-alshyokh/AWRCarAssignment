import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:flutter/material.dart';

class UnExpectedErrorWidget extends StatelessWidget {
  final double? width;
  final Function() callback;

  const UnExpectedErrorWidget({super.key, required this.callback, this.width});

  @override
  Widget build(BuildContext context) {
    double widthC = width ?? DeviceUtils.getScaledWidth(context, 1);
    return SizedBox(
        width: widthC,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: widthC * .5,
              ),
              const SizedBox(
                height: AppDimens.space15,
              ),
              Text(translate.woops,
                  textAlign: TextAlign.center,
                  style: appTextStyle.middleTSBasic.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryOrangeColor)),
              const SizedBox(
                height: AppDimens.space15,
              ),
              Text(translate.something_went_wrong_check_connection,
                  textAlign: TextAlign.center,
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.secondaryDarkGrayColor)),
              const SizedBox(
                height: AppDimens.space15,
              ),
              ElevatedButton(
                  onPressed: callback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryOrangeColor.withOpacity(0.7),
                    surfaceTintColor:
                        AppColors.primaryOrangeColor.withOpacity(0.7),
                    // minimumSize: Size(88, 36),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.space16),
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppRadius.radius10)),
                    ),
                  ),
                  child: Text(
                    translate.try_again,
                    style: appTextStyle.smallTSBasic
                        .copyWith(color: AppColors.white),
                  ))
            ],
          ),
        ));
  }
}