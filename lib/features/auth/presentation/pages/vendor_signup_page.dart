import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/helper/shared_preference_helper.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/utils/vaildators/base_validator.dart';
import 'package:car_tracking_app/core/utils/vaildators/match_validator.dart';
import 'package:car_tracking_app/core/utils/vaildators/required_validator.dart';
import 'package:car_tracking_app/core/widgets/animations/coulumn_animation_widget.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/core/widgets/common/title_section_widget.dart';
import 'package:car_tracking_app/core/widgets/textfields/rounded_textformfield_widget.dart';
import 'package:flutter/material.dart';

class VendorSignUpPage extends BaseAppStatefulWidget {
  const VendorSignUpPage({super.key});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() =>
      _VendorSignUpPageState();
}

class _VendorSignUpPageState extends BaseAppState<VendorSignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController? _vendorNameController;
  late final TextEditingController? _vendorContactNumberController;

  late final TextEditingController? _vendorPasswordController;
  late final TextEditingController? _vendorConfirmPasswordController;

  final String defaultVendorName = "John Smith";
  final String defaultVendorContactNumber = "(+971) 512345678";

  @override
  void initState() {
    super.initState();
    _vendorNameController = TextEditingController(text: defaultVendorName);
    _vendorContactNumberController =
        TextEditingController(text: defaultVendorContactNumber);

    _vendorPasswordController = TextEditingController(text: "");
    _vendorConfirmPasswordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    final appBar = CustomAppBar(
      title: translate.sign_up,
      titleColor: AppColors.secondaryDarkGrayColor,
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.vendorSignUpBG,
      statusBarColor: AppColors.vendorSignUpBG,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.vendorSignUpBG,
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
                    AppAssets.vendorPlaceholder,
                    height: 200,
                  ),
                  ColumnAnimationWidget(children: [
                    /// Vendor full name (required)
                    _vendorFullNameFieldWidget(width: width),

                    const SizedBox(
                      height: AppDimens.space10,
                    ),

                    /// vendor Contact number (required)
                    _vendorContactNumberFieldWidget(width: width),

                    const SizedBox(
                      height: AppDimens.space10,
                    ),

                    /// vendor password (Optional for test)
                    _vendorPasswordFieldWidget(width: width),

                    const SizedBox(
                      height: AppDimens.space10,
                    ),

                    /// vendor confirm password (Optional for test but should also match the password if any of them has value)
                    _vendorConfirmPasswordFieldWidget(width: width),

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
                            translate.create,
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
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _vendorFullNameFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.full_name,
        child: RoundedFormField(
          key: const ValueKey<String>('input.full_name'),
          controller: _vendorNameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return BaseValidator.validateValue(
                context, value!, [RequiredValidator()]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.name,
          contentPadding: const EdgeInsets.fromLTRB(
              AppDimens.space10, 0, AppDimens.space10, AppDimens.space10),
          hintText: translate.enter_your_fullname_hint,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  Widget _vendorContactNumberFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.contact_number,
        child: RoundedFormField(
          key: const ValueKey<String>('input.contact_number'),
          controller: _vendorContactNumberController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return BaseValidator.validateValue(
                context, value!, [RequiredValidator()]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.phone,
          contentPadding: const EdgeInsets.fromLTRB(
              AppDimens.space10, 0, AppDimens.space10, AppDimens.space10),
          hintText: translate.enter_your_contact_number,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  Widget _vendorPasswordFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.password,
        child: RoundedPasswordFormField(
          key: const ValueKey<String>('input.password'),
          controller: _vendorPasswordController,
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

  Widget _vendorConfirmPasswordFieldWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.confirm_password,
        child: RoundedPasswordFormField(
          key: const ValueKey<String>('input.confirm_password'),
          controller: _vendorConfirmPasswordController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            return BaseValidator.validateValue(context, value!,
                [MatchValidator(value: _vendorPasswordController?.text ?? "")]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.text,
          contentPadding: const EdgeInsets.fromLTRB(
              AppDimens.space10, 0, AppDimens.space10, AppDimens.space10),
          hintText: translate.re_enter_your_password,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AppUtils.unFocus(context);
      SharedPreferenceHelper preferenceHelper =
          findDep<SharedPreferenceHelper>();
      await preferenceHelper
          .setVendorFullName(_vendorNameController?.text ?? defaultVendorName);
      await preferenceHelper.setVendorContactNumber(
          _vendorContactNumberController?.text ?? defaultVendorContactNumber);

      /// flashing an event for new sign up action
      eventTracker(event: ButtonAnalyticIdentity.vendorSignUp);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.vendorCarListPage,
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
    _vendorContactNumberController?.dispose();
    _vendorPasswordController?.dispose();
    _vendorConfirmPasswordController?.dispose();
    _vendorNameController?.dispose();
    super.dispose();
  }
}
