import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/bouncing_button.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends BaseAppStatefulWidget {
  const LoginPage({super.key});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() => _LoginPageState();
}

class _LoginPageState extends BaseAppState<LoginPage> {
  bool didPop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        automaticallyImplyLeading: false,
        title: '',
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Login Page"),
            BouncingButton(
              child: Text(
                'Login',
                style: appTextStyle.middleTSBasic.copyWith(
                    color: AppColors.white
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.mainPage);
              },
            )
          ],
        ),
      ),
    );
  }
}
