// Flutter imports:
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Project imports:

/// A [StatefulWidget] that displays a location picker bottom sheet.
///
/// Users can select a location from the map, and the selected location
/// will be passed to the [onLocationSelected] callback.
class LocationPickerBottomSheet extends StatefulWidget {
  /// Creates a new [LocationPickerBottomSheet] instance.
  ///
  /// [key] is an optional [Key] for the widget.
  /// [onLocationSelected] is a required callback function that is called
  /// when a location is selected.
  /// [initValue] is an optional initial [LatLng] value for the map.
  const LocationPickerBottomSheet({
    super.key,
    required this.onLocationSelected,
    this.initValue,
  });

  final AppLatLng? initValue;
  final Function(AppLatLng) onLocationSelected;

  @override
  _LocationPickerBottomSheetState createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState extends State<LocationPickerBottomSheet> {
  // GoogleMapController? _controller;
  AppLatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      withDone: false,
      padding: EdgeInsets.zero,
      textHeader: "Choose location",
      childContent: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            AppMapWidget(
              latLng: _selectedLocation,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              onLocationSelected: (latLng) {
                if (mounted) {
                  setState(() {
                    _selectedLocation = latLng;
                  });
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.space16),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      _selectedLocation != null
                          ? AppColors.primaryOrangeColor
                          : AppColors.lightGray,
                    ),
                  ),
                  onPressed: _selectedLocation != null
                      ? () {
                          widget.onLocationSelected(_selectedLocation!);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pop(context);
                          });
                        }
                      : null,
                  child: Text(
                    translate.select_location,
                    style: appTextStyle.middleTSBasic.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
