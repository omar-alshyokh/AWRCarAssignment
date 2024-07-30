// Flutter imports:
import 'package:car_tracking_app/core/widgets/common/restart_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/dialog/base_dialog.dart';

/// This class is using [BaseDialog] under the hood for best customization.
///
/// See also [ConfirmDialog] and [MessageIconDialog].
class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguage appLanguage = Provider.of<AppLanguage>(context);
    return BaseDialog(
      withDivider: true,
      title: translate.change_language,
      child: Wrap(
        children: AppConstants.listOfLanguages
            .map(
              (language) => _selectedButton(
                title: language.label,
                langCode: language.code,
                currentValue: appLanguage.langCode == language.code,
                appLanguage: appLanguage,
                context: context,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _selectedButton({
    String? title,
    required String langCode,
    // required String langFlag,
    bool currentValue = false,
    required AppLanguage appLanguage,
    required BuildContext context,
  }) {
    Widget? icon;
    Widget? langTitle;
    Color? currentColor;
    if (currentValue) {
      currentColor = AppColors.primaryOrangeColor;
    }
    langTitle = Text(
      title ?? "",
      style: appTextStyle.middleTSBasic.copyWith(
        color: currentValue ? AppColors.black : AppColors.black,
        fontWeight: currentValue ? FontWeight.bold : FontWeight.normal,
      ),
    );

    if (currentValue) {
      icon = const Icon(
        Icons.check_circle,
        color: AppColors.white,
      );
    } else {
      icon = const SizedBox();
    }

    return AppInkWellWidget(
      onTap: () async {
        if (currentValue) {
          Navigator.pop(context);
          return;
        }
        appLanguage.changeLanguage(Locale(langCode));

        Navigator.pop(context);
        RestartWidget.restartApp(context);

      },
      child: Container(
        padding: const EdgeInsets.all(AppDimens.space12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.radius12,
          ),
          color: currentColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            langTitle,
            icon,
          ],
        ),
      ),
    );
  }
}
