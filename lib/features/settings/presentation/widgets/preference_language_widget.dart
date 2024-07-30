import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/widgets/dialog/change_language_dailog.dart';
import 'package:car_tracking_app/features/settings/presentation/widgets/setting_item_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferenceLanguageWidget extends StatelessWidget {
  const PreferenceLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguage languageManager = context.watch<AppLanguage>();
    return SettingItemTileWidget(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.space20,
        horizontal: 0,
      ),
      icon: const Icon(
        Icons.language_rounded,
        size: 24,
        color: AppColors.black,
      ),
      onPress: () async {
        await _changeLanguageAction(context: context);
      },
      title: translate.change_language,
      trailingText: languageManager.getLangLabel(),
    );
  }

  Future _changeLanguageAction({required BuildContext context}) {
    return AppUtils.appShowDialog(
      context: context,
      builder: (context) => const ChangeLanguageDialog(),
    );
  }
}
