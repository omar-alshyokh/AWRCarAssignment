// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

// Project imports:

import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_extensions.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/common/app_rotated_box_language.dart';

class SettingItemTileWidget extends StatelessWidget {
  const SettingItemTileWidget({
    this.title,
    this.trailingText,
    this.trailing,
    this.icon,
    this.textColor,
    this.onPress,
    this.padding,
    this.isComingSoon = false,
    super.key,
  });

  final String? title;
  final String? trailingText;
  final Widget? icon;
  final Widget? trailing;
  final Color? textColor;
  final bool isComingSoon;
  final VoidCallback? onPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AppInkWellWidget(
      onTap: onPress,
      borderRadius: BorderRadius.zero,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppDimens.space20,
              horizontal: AppDimens.space16,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: AppDimens.space16,
              ),
            if (title != null)
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title!,
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: textColor ?? AppColors.black),
                    ),
                    if (isComingSoon)
                      Text(
                        ' (${translate.coming_soon})',
                        style: appTextStyle.smallTSBasic.copyWith(
                          color: AppColors.primaryGrayColor,
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(
              width: AppDimens.space8,
            ),
            trailing ??
                Visibility(
                  visible: trailingText.itHasValue,
                  child: Text(
                    trailingText ?? "",
                    style: appTextStyle.minTSBasic
                        .copyWith(color: AppColors.primaryGrayColor),
                  ),
                ),
            if (trailing == null)
              const SizedBox(
                width: AppDimens.space8,
              ),
            if (trailing == null)
              const AppRotatedBoxLanguage(
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.black,
                  size: 12,
                ),
              )
          ],
        ),
      ),
    );
  }
}
