import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget child;

  const CustomDialog({super.key, required this.child, required this.title});

  @override
  State<StatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: AppDurations.defaultDialogAnimationDuration));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.only(
                  left: AppDimens.space20, right: AppDimens.space20),
              padding: const EdgeInsets.all(AppDimens.space10),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: AppDimens.space10,
                  ),
                  Text(
                    widget.title,
                    style: appTextStyle.middleTSBasic.copyWith(
                        fontSize: AppTextSize.subBig,
                        color: AppColors.primaryOrangeColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(
                    color: AppColors.lightGray,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  widget.child
                ],
              )),
        ),
      ),
    );
  }
}
