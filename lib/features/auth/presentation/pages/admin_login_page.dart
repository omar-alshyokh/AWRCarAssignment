import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/utils/vaildators/base_validator.dart';
import 'package:car_tracking_app/core/widgets/animations/coulumn_animation_widget.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/core/widgets/common/title_section_widget.dart';
import 'package:car_tracking_app/core/widgets/textfields/rounded_textformfield_widget.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends BaseAppStatefulWidget {
  const AdminLoginPage({super.key});


  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends BaseAppState<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController? _adminNameController;
  late final TextEditingController? _adminPasswordController;

  @override
  void initState() {
    super.initState();
    _adminNameController = TextEditingController(text: "");
    _adminPasswordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    final appBar = CustomAppBar(
      title: translate.sign_in,
      titleColor: AppColors.secondaryDarkGrayColor,
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.adminSignUpBG,
      statusBarColor:AppColors.adminSignUpBG,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.adminSignUpBG,
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.space16),
              child: Column(
                children: [

                  Image.asset(
                    AppAssets.adminPlaceholder,
                    height: 200,
                  ),

                  ColumnAnimationWidget(children: [
                    const SizedBox(
                      height: AppDimens.space32,
                    ),

                    /// Admin username (Optional for test)
                    _adminUserNameFieldWidget(width: width),

                    const SizedBox(
                      height: AppDimens.space10,
                    ),

                    /// Admin password (Optional for test)
                    _adminPasswordFieldWidget(width: width),

                    const SizedBox(
                      height: AppDimens.space36,
                    ),

                    /// Create new vendor button
                    CustomElevatedButton(
                      backgroundColor: AppColors.secondaryDarkGrayColor,
                      borderRadius: AppRadius.radius12,
                      elevation: 2,
                      onPressed: _submitForm,
                      child: SizedBox(
                        width: width,
                        child: Center(
                          child: Text(
                            translate.submit,
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimens.space10,
                    ),
                    const SizedBox(
                      height: AppDimens.space48,
                    ),

                  ]),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _adminUserNameFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.username,
        child: RoundedFormField(
          key: const ValueKey<String>('input.username'),
          controller: _adminNameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return BaseValidator.validateValue(context, value!, []);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.name,
          contentPadding: const EdgeInsets.fromLTRB(
              AppDimens.space10, 0, AppDimens.space10, AppDimens.space10),
          hintText: translate.enter_your_username,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  Widget _adminPasswordFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.password,
        child: RoundedPasswordFormField(
          key: const ValueKey<String>('input.password'),
          controller: _adminPasswordController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return BaseValidator.validateValue(context, value!, []);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.text,
          contentPadding: const EdgeInsets.fromLTRB(
              AppDimens.space10, 0, AppDimens.space10, AppDimens.space10),
          hintText: translate.enter_your_password,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AppUtils.unFocus(context);

      /// flashing an event for admin sign in action
      eventTracker(event: ButtonAnalyticIdentity.adminSignIn);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainPage,
        (route) => false,
      );
    } else {
      SnackBarUtil.showWarningAlert(
          context: context,
          title: translate.missing_info,
          body: translate.please_fill_the_required_fields);
    }
  }

  @override
  void dispose() {
    _adminPasswordController?.dispose();
    _adminNameController?.dispose();

    super.dispose();
  }
}
