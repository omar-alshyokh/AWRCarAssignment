import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/animations/coulumn_animation_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/features/settings/presentation/widgets/preference_language_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    double margins = 0.1013 * width;
    final appBar = CustomAppBar(
      automaticallyImplyLeading: false,
      title: translate.settings,
      centerTitle: true,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top -
        margins;
    return Scaffold(
      appBar: appBar,
      body: const Padding(
        padding: EdgeInsets.all(AppDimens.space16),
        child: ColumnAnimationWidget(
          children: [

            PreferenceLanguageWidget(),
          ],
        ),
      ),
    );
  }
}
