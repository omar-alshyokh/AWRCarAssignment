import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_text_size.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [supplementaryText] will be discarded for now as a design requirement.
  const CustomAppBar(
      {super.key, this.title,
      this.automaticallyImplyLeading = true,
      this.customTitle,
      this.backgroundColor,
      this.titleColor,
      this.statusBarColor,
      this.onBack,
      this.actions,
      this.systemUiOverlayStyle,
      this.toolbarHeight,
      this.centerTitle,
      this.backColor = AppColors.black,
      this.enableBackAction = false});

  final String? title;
  final double? toolbarHeight;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final Widget? customTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? statusBarColor;
  final Color backColor;
  final VoidCallback? onBack;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  /// this property used for catch studio project in case to reload the catch
  final bool enableBackAction;

  @override
  Widget build(BuildContext context) {
    List<Widget> customActions = [];
    if (actions != null) {
      customActions.addAll(actions!);
    }
    customActions.add(const SizedBox(width: 20));
    final leftPadding = automaticallyImplyLeading ? 0.0 : 18.0;
    Widget child = AppBar(
      systemOverlayStyle: systemUiOverlayStyle ??
          SystemUiOverlayStyle(
              statusBarColor: statusBarColor ?? AppColors.white,
              statusBarIconBrightness: Brightness.dark),
      shadowColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle?? automaticallyImplyLeading,
      actions: customActions,
      toolbarHeight: toolbarHeight ?? (customTitle != null ? 85 : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? IconButton(
              onPressed: onBack ??
                  () {
                    Navigator.of(context).pop();
                  },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: backColor,
              ),
              // tooltip: 'Back',  // this cause the overlay
            )
          : null,
      foregroundColor: AppColors.secondaryDarkGrayColor,
      backgroundColor: backgroundColor ?? AppColors.white,
      titleSpacing: 8,
      leadingWidth: 60,
      title: customTitle ??
          _CustomAppBarTextWidget(
            title: title??"",
            titleColor:titleColor,
            titleLeftPadding: leftPadding,
            fontSize: automaticallyImplyLeading
                ? AppTextSize.normal
                : AppTextSize.subBig,
          ),
    );
    return enableBackAction
        ? child
        : IgnorePointer(
            ignoring: kIsWeb,
            child: child,
          );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(customTitle == null ? kToolbarHeight : 85);
}

class _CustomAppBarTextWidget extends StatelessWidget {
  const _CustomAppBarTextWidget({
    required this.title,
    required this.titleLeftPadding,
    required this.fontSize,
    this.titleColor,
  });

  final String title;
  final double titleLeftPadding;
  final double fontSize;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> titleColumn = [
      Text(title,
          style: appTextStyle.subBigTSBasic.copyWith(
              fontSize: fontSize, color:titleColor?? AppColors.primaryOrangeColor)),
    ];

    return Padding(
      padding: EdgeInsets.only(left: titleLeftPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: titleColumn,
      ),
    );
  }
}
