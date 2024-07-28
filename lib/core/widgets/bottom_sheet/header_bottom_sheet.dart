// Flutter imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:

class HeaderBottomSheet extends StatelessWidget {
  const HeaderBottomSheet({
    super.key,
    this.onClose,
    required this.title,
    this.onChoose,
    this.withCloseIcon = true,
  });

  final String title;
  final Function()? onClose;
  final Function()? onChoose;
  final bool withCloseIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: double.infinity),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.space8,
              ),
              child: IconButton(
                onPressed: onClose ??
                    () {
                      Navigator.of(context).pop();
                    },
                icon: withCloseIcon
                    ? const Icon(
                        Icons.close,
                        size: 24,
                        color: AppColors.secondaryDarkGrayColor,
                      )
                    : Container(),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: appTextStyle.middleTSBasic.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
