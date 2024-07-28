// Flutter imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:


class MapNavigationBottomSheet extends StatelessWidget {
  const MapNavigationBottomSheet({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);
  final Function onNavigate;

  @override
  Widget build(BuildContext context) {
    // double width = DeviceUtils.getScaledWidth(context, 1.0);
    // double height = DeviceUtils.getScaledHeight(context, 1.0);

    return BaseBottomSheet(
      textHeader: '',
      withDone: false,
      withClear: false,
      childContent: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const SizedBox(height: AppDimens.space8,),
          AppInkWellWidget(
            onTap: () {
              Navigator.pop(context);
              onNavigate();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.space12,
                  horizontal: AppDimens.space20),
              // height: AppDimens.fieldHeight * widget.width,
              alignment: AlignmentDirectional.centerStart,
              decoration: const BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppRadius.radius10)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_rounded,
                    size: 30,
                    color: AppColors.secondaryDarkGrayColor,
                  ),
                  const SizedBox(
                    width: AppDimens.space12,
                  ),
                  Text(
                    translate.direction,
                    style: appTextStyle.middleTSBasic.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // VerticalTextPadding.with16(),
          const SizedBox(height: AppDimens.space16,),
        ],
      ),
    );
  }
}
