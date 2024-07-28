import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final TextStyle? style;

  const TitleSectionWidget(
      {super.key, required this.title, required this.child, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: style ??
              appTextStyle.middleTSBasic.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: AppDimens.space8,
        ),
        child
      ],
    );
  }
}
