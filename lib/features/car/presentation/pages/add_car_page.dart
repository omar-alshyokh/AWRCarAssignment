import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/helper/location_helper.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/utils/vaildators/base_validator.dart';
import 'package:car_tracking_app/core/utils/vaildators/required_validator.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/location_picker_bottom_sheet_widget.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/core/widgets/common/title_section_widget.dart';
import 'package:car_tracking_app/core/widgets/custom_dropdown_widget.dart';
import 'package:car_tracking_app/core/widgets/textfields/rounded_textformfield_widget.dart';
import 'package:car_tracking_app/features/car/data/models/brand_model.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/data/models/car_type_model.dart';
import 'package:car_tracking_app/features/car/presentation/bloc/car_bloc.dart';
import 'package:car_tracking_app/features/map/presentation/widgets/tap_to_select_your_place_on_map_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  late final CarBloc carBloc;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController? _currentCarKilometersController;

  BrandModel? selectedBrand = AppConstants.mockBrandList.first;

  CarTypeModel? selectedCar;

  AppLatLng? latLngPickupLocation;
  AppLatLng? latLngDropOffLocation;
  String? pickupLocationStr;
  String? dropOffLocationStr;

  late final TextEditingController? _carPlateNumberController;
  late final TextEditingController? _carModelYearController;

  List<CarTypeModel> get carsBySelectedBrand => AppConstants.mockCarByBrandList
      .where((car) => car.brandId == selectedBrand?.id)
      .toList();

  @override
  void initState() {
    super.initState();
    carBloc = CarBloc();

    _currentCarKilometersController = TextEditingController(text: "");
    _carPlateNumberController = TextEditingController(text: "");
    _carModelYearController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    final appBar = CustomAppBar(
      title: translate.add_car,
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<CarBloc, CarState>(
        bloc: carBloc,
        listener: (context, state) {
          if (state is AddCarSuccess) {
            String? carName = selectedCar?.name;
            String? carYear = _carModelYearController?.text;
            String carDetails = carName.itHasValue
                ? "$carName ${carYear.itHasValue ? "($carYear)" : ""}"
                : "";
            SnackBarUtil.showCustomFlash(
                context: context,
                icon: const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.white,
                ),
                title: translate.add_new_car,
                body: translate.add_new_car_success_body(carDetails));
            _resetForm();
            Navigator.pop(context);
          } else if (state is AddCarFailed) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          return Form(
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
                      /// Brand Dropdown
                      /// choose car brand
                      _carBrandDropDownWidget(width: width),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// Model Dropdown
                      /// choose car model
                      _carModelDropDownWidget(width: width),
                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// Selected Car Image
                      _carDetailsWidget(width: width),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// Current KM
                      _currentCarKMWidget(width: width),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// pick-up location address on the map
                      _buildTapToSelectPickUpPlaceOnMap(),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// drop-off location address on the map
                      _buildTapToSelectDropOffPlaceOnMap(),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// car plate number
                      _carPlateNumberWidget(width: width),

                      const SizedBox(
                        height: AppDimens.space10,
                      ),

                      /// car model year
                      _carModelYearWidget(width: width),
                      const SizedBox(
                        height: AppDimens.space36,
                      ),
                      // Submit Button
                      CustomElevatedButton(
                        backgroundColor: AppColors.primaryOrangeColor,
                        borderRadius: AppRadius.radius12,
                        elevation: 2,
                        onPressed:
                            (state is AddCarLoading) ? null : _submitForm,
                        child: SizedBox(
                          width: width,
                          child: Center(
                            child: (state is AddCarLoading)
                                ? const AppLoader(
                                    size: AppLoaderSize.tiny,
                                    iconColor: AppColors.white,
                                  )
                                : Text(
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _carBrandDropDownWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.car_brand,
        child: CustomDropdown<BrandModel>(
          items: AppConstants.mockBrandList,
          hintIcon: const Icon(
            Icons.list,
            size: 16,
            color: AppColors.black,
          ),
          hintText: translate.hint_select_brand,
          selectedValue: selectedBrand,
          itemBuilder: (item) {
            return Text(
              item.name,
              style: appTextStyle.middleTSBasic.copyWith(
                color: AppColors.black,
              ),
            );
          },
          onChanged: (BrandModel? value) {
            setState(() {
              selectedBrand = value!;
              selectedCar = null; // Reset selected car
            });
          },
          buttonWidth: width,
          dropdownWidth: width - (AppDimens.space32),
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14,
            color: AppColors.black,
          ),
        ));
  }

  Widget _carModelDropDownWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.car_model,
        child: CustomDropdown<CarTypeModel>(
          items: carsBySelectedBrand,
          hintIcon: const Icon(
            Icons.list,
            size: 16,
            color: AppColors.black,
          ),
          hintText: translate.hint_select_car_model,
          selectedValue: selectedCar,
          itemBuilder: (item) {
            return Text(
              item.name,
              style: appTextStyle.middleTSBasic.copyWith(
                color: AppColors.black,
              ),
            );
          },
          onChanged: (CarTypeModel? value) {
            setState(() {
              selectedCar = value!;
            });
          },
          buttonWidth: width,
          dropdownWidth: width - (AppDimens.space32),
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14,
            color: AppColors.black,
          ),
        ));
  }

  Widget _carDetailsWidget({required double width}) {
    if (selectedCar != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 125,
            child: Image.asset(
              selectedCar!.image,
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _currentCarKMWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.current_car_kilometers,
        child: RoundedFormField(
          key: const ValueKey<String>('input.current_car_kilometers'),
          controller: _currentCarKilometersController,
          maxLength: 255,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return BaseValidator.validateValue(
                context, value!, [RequiredValidator()]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.number,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          hintText: translate.current_car_kilometers_hint,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  Widget _buildTapToSelectPickUpPlaceOnMap() {
    return TitleSectionWidget(
      title: translate.pick_up_location,
      child: TapToSelectYourPlaceOnMapWidget(
        latLng: latLngPickupLocation,
        locationStr: pickupLocationStr ??
            "${latLngPickupLocation?.latitude}, ${latLngPickupLocation?.longitude}",
        onTap: () {
          AppBottomSheet.showAppModalBottomSheet(
            context,
            LocationPickerBottomSheet(
              initValue: latLngPickupLocation,
              onLocationSelected: (latLong) {
                if (mounted) {
                  Future.delayed(Duration.zero, () async {
                    setState(() {
                      latLngPickupLocation = latLong;
                    });

                    final String? location =
                        await getLocationPlace(latLngPickupLocation!);
                    if (location.itHasValue) {
                      pickupLocationStr = location;
                    }
                    setState(() {});
                  });
                }
              },
            ),
            enableDrag: false,
          );
        },
      ),
    );
  }

  Widget _buildTapToSelectDropOffPlaceOnMap() {
    return TitleSectionWidget(
      title: translate.drop_off_location,
      child: TapToSelectYourPlaceOnMapWidget(
        latLng: latLngDropOffLocation,
        locationStr: dropOffLocationStr ??
            "${latLngDropOffLocation?.latitude}, ${latLngDropOffLocation?.longitude}",
        onTap: () {
          AppBottomSheet.showAppModalBottomSheet(
            context,
            LocationPickerBottomSheet(
              initValue: latLngDropOffLocation,
              onLocationSelected: (latLong) {
                if (mounted) {
                  Future.delayed(Duration.zero, () async {
                    setState(() {
                      latLngDropOffLocation = latLong;
                    });

                    final String? location =
                        await getLocationPlace(latLngDropOffLocation!);
                    if (location.itHasValue) {
                      dropOffLocationStr = location;
                    }
                    setState(() {});
                  });
                }
              },
            ),
            enableDrag: false,
          );
        },
      ),
    );
  }

  Widget _carPlateNumberWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.car_plate_number,
        child: RoundedFormField(
          key: const ValueKey<String>('input.car_plate_number'),
          controller: _carPlateNumberController,
          maxLength: 255,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return BaseValidator.validateValue(
                context, value!, [RequiredValidator()]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.text,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          hintText: translate.car_plate_number_hint,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  Widget _carModelYearWidget({required double width}) {
    return TitleSectionWidget(
        title: translate.car_model_year,
        child: RoundedFormField(
          key: const ValueKey<String>('input.car_model_year'),
          controller: _carModelYearController,
          maxLength: 255,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return BaseValidator.validateValue(
                context, value!, [RequiredValidator()]);
          },
          textAlign: TextAlign.start,
          borderColor: AppColors.black,
          keyboardType: TextInputType.number,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          hintText: translate.car_model_year_hint,
          borderRadius: AppRadius.radius8,
          fillColor: AppColors.white,
          filled: true,
        ));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        latLngPickupLocation != null &&
        latLngDropOffLocation != null &&
        selectedCar != null) {
      _formKey.currentState!.save();
      var uuid = const Uuid();

      final car = CarModel(
          id: uuid.v4(),
          // Will be set by Firestore
          name: selectedCar?.name ?? '',
          brandName: selectedBrand?.name,
          imageUrl: selectedCar?.image ?? '',
          currentKm: _currentCarKilometersController?.text ?? "",
          pickUpLocationLatitude: latLngPickupLocation?.latitude ?? 0.0,
          pickUpLocationLongitude: latLngPickupLocation?.longitude ?? 0.0,
          dropOffLocationLatitude: latLngDropOffLocation?.latitude ?? 0.0,
          dropOffLocationLongitude: latLngDropOffLocation?.longitude ?? 0.0,
          currentLocationLatitude: latLngPickupLocation?.latitude ?? 0.0,
          currentLocationLongitude: latLngPickupLocation?.longitude ?? 0.0,
          carPlate: _carPlateNumberController?.text ?? "",
          modelYear: _carModelYearController?.text ?? "",
          // Status set to 1 -> pending
          status: 2,
          createdAt: Timestamp.now(),
          /// for delete
          pickUpTime: Timestamp.fromDate(DateTime.now().add(const Duration(minutes: 30))),
          vendorContactNumber: "(+971) 501234567",
          vendorUserName: "Ahmed Aziz",


      );

      carBloc.add(AddCarEvent(car));
      AppUtils.unFocus(context);
    } else {
      SnackBarUtil.showWarningAlert(
          context: context,
          title: translate.missing_info,
          body: translate.please_fill_the_car_details_info);
    }
  }

  void _resetForm() {
    if (mounted) {
      selectedBrand = AppConstants.mockBrandList.first;
      selectedCar = null;
      pickupLocationStr = "";
      dropOffLocationStr = "";
      latLngDropOffLocation = null;
      latLngPickupLocation = null;
      if (_currentCarKilometersController != null) {
        _currentCarKilometersController.clear();
      }
      if (_carPlateNumberController != null) {
        _carPlateNumberController.clear();
      }
      if (_carModelYearController != null) {
        _carModelYearController.clear();
      }
      _currentCarKilometersController?.text = "";

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
    _formKey.currentState?.reset();
  }

  Future<String?> getLocationPlace(AppLatLng latLng) async {
    try {
      final placeMark = await LocationHelper.getAddressFromLatLng(
        latLng.latitude,
        latLng.longitude,
      );
      if (placeMark != null) {
        String descriptionValue = LocationHelper.getLoc(placeMark);
        if (descriptionValue.isNotEmpty) {
          return descriptionValue;
        }
      }
    } catch (error, stack) {
      LoggerService().logError(error.toString(), stack);
    }
    return null;
  }

  @override
  void dispose() {
    _carModelYearController?.dispose();
    _carPlateNumberController?.dispose();
    _currentCarKilometersController?.dispose();
    carBloc.close();
    super.dispose();
  }
}
