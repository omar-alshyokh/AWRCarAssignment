import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:flutter/material.dart';

class TapToSelectYourPlaceOnMapWidget extends StatelessWidget {
  const TapToSelectYourPlaceOnMapWidget({
    super.key,
    required this.onTap,
    required this.latLng,
    required this.locationStr,
  });

  final Function() onTap;
  final AppLatLng? latLng;
  final String locationStr;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: latLng == null ? 60 : null,
      duration: const Duration(
        milliseconds: AppDurations.shortAnimationDuration,
      ),
      child: AppInkWellWidget(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(AppDimens.space16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.radius8),
              border: Border.all(
                color: AppColors.black,
                width: 0.5,
              ),
              color: AppColors.white,
            ),
            child: latLng != null ? _editLocationWidget() : _tapToPickWidget()),
      ),
    );
  }

  Widget _editLocationWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColors.secondaryDarkGrayColor,
              size: 24,
            ),
            const SizedBox(
              height: AppDimens.space4,
            ),
            Text(
              translate.tap_to_edit,
              style: appTextStyle.smallTSBasic.copyWith(
                color: AppColors.secondaryDarkGrayColor,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        const SizedBox(width: AppDimens.space4,),
        Container(
          width: 1.0,
          height: 60,
          color: AppColors.secondaryDarkGrayColor,
        ),
        const SizedBox(width: AppDimens.space4,),
        Expanded(
          child: Text(
            locationStr,
            style: appTextStyle.middleTSBasic.copyWith(
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _tapToPickWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.secondaryDarkGrayColor,
          size: 24,
        ),
        const SizedBox(
          width: AppDimens.space4,
        ),
        Expanded(
          child: Text(
            translate.tap_to_pick_the_location_on_the_map,
            style: appTextStyle.middleTSBasic.copyWith(
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
