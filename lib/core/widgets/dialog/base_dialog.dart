// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';

/// This is the base dialog widget for styling and size customizations.
///
/// The following are the derived classes [ConfirmDialog],
/// [ChangeLanguageDialog] and [MessageIconDialog].
class BaseDialog extends StatefulWidget {
  const BaseDialog({
    super.key,
    required this.title,
    required this.child,
    this.withDivider = false,
  });

  final Widget child;
  final String title;
  final bool withDivider;

  @override
  State<StatefulWidget> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppDurations.defaultDialogAnimationDuration,
      ),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    const width = AppDimens.dialogWidth;
    return Center(
      child: Material(
        color: AppColors.transparent,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: width,
            margin: const EdgeInsets.all(AppDimens.space32),
            padding: const EdgeInsets.all(AppDimens.space20),
            decoration: ShapeDecoration(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.radius24),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: appTextStyle.normalTSBasic.copyWith(
                          color: AppColors.primaryOrangeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.withDivider)
                  const Divider(color: AppColors.primaryGrayColor),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
