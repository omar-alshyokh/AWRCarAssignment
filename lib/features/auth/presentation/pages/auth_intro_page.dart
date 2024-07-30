import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/widgets/buttons/bouncing_button.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AuthIntroPage extends BaseAppStatefulWidget {
  const AuthIntroPage({super.key});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() => _LoginPageState();
}

class _LoginPageState extends BaseAppState<AuthIntroPage> {
  bool didPop = false;

  @override
  Widget build(BuildContext context) {
    const appBar = CustomAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      statusBarColor: AppColors.white,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.space16),
        child: Column(
          children: [
            /// logo AWR
            _animatedLogo(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideInUp(
                    duration: const Duration(
                        milliseconds: AppDurations.longAnimationDuration),
                    from: 1000,
                    delay: const Duration(
                        milliseconds: AppDurations.shortAnimationDelay),
                    child: BouncingButton(
                      child: Text(
                        translate.continue_as_awr_admin,
                        style: appTextStyle.middleTSBasic
                            .copyWith(color: AppColors.white),
                      ),
                      onPressed: () {
                        /// flashing an event for processing admin session
                        eventTracker(
                            event: ButtonAnalyticIdentity.continueAsAdmin);
                        Navigator.pushNamed(context, AppRoutes.adminLoginPage);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.space20,
                  ),
                  SlideInUp(
                    duration: const Duration(
                        milliseconds: AppDurations.longAnimationDuration),
                    from: 1000,
                    delay: const Duration(
                        milliseconds: AppDurations.longAnimationDelay),
                    child: BouncingButton(
                      child: Text(
                        translate.continue_as_vendor,
                        style: appTextStyle.middleTSBasic
                            .copyWith(color: AppColors.white),
                      ),
                      onPressed: () {
                        /// flashing an event for processing vendor session
                        eventTracker(
                            event: ButtonAnalyticIdentity.continueAsVendor);

                        Navigator.pushNamed(
                            context, AppRoutes.vendorSignUpPage);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedLogo() {
    const duration = Duration(
      milliseconds: AppDurations.shortAnimationDuration,
    );
    return SlideInDown(
      duration:
          const Duration(milliseconds: AppDurations.longAnimationDuration),
      from: 1000,
      child: AnimatedContainer(
        duration: duration,
        width: 200,
        height: 200,
        child: Image.asset(
          AppAssets.appLogo,
          height: 200,
        ),
      ),
    );
  }
}
