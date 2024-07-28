import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final Widget? hintIcon;
  final String? hintText;
  final T? selectedValue;
  final void Function(T?)? onChanged;
  final double buttonHeight;
  final double buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final double dropdownMaxHeight;
  final double dropdownWidth;
  final BoxDecoration? dropdownDecoration;
  final Widget icon;
  final double itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final Widget Function(T) itemBuilder;

  const CustomDropdown({
    super.key,
    required this.items,
    this.hintIcon,
    this.hintText,
    this.selectedValue,
    this.onChanged,
    this.buttonHeight = 55,
    required this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.dropdownMaxHeight = 200,
    required this.dropdownWidth,
    this.dropdownDecoration,
    required this.icon,
    this.itemHeight = 40,
    this.itemPadding,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Row(
          children: [
            if (hintIcon != null)
              const Row(
                children: [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: AppColors.black,
                  ),
                  SizedBox(
                    width: AppDimens.space4,
                  ),
                ],
              ),
            Expanded(
              child: Text(
                hintText ?? translate.select_item,
                style:
                    appTextStyle.middleTSBasic.copyWith(color: AppColors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: itemBuilder(item),
          );
        }).toList(),
        value: selectedValue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight,
          width: buttonWidth,
          padding: buttonPadding ??
              const EdgeInsets.symmetric(horizontal: AppDimens.space14),
          decoration: buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.radius12),
                border: Border.all(
                  color: AppColors.black,
                  width: 0.6
                ),
                color: AppColors.white,
              ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: icon,
          iconSize: 14,
          iconEnabledColor: AppColors.black,
          iconDisabledColor: AppColors.primaryGrayColor,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: dropdownMaxHeight,
          width: dropdownWidth,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.radius12),
                color: AppColors.white,
              ),
          offset: const Offset(0, -1),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
            trackColor: WidgetStateProperty.all<Color>(AppColors.lightGray),
            thumbColor: WidgetStateProperty.all<Color>(AppColors.lightGray),
            trackBorderColor:
                WidgetStateProperty.all<Color>(AppColors.lightGray),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight,
          padding: itemPadding ??
              const EdgeInsets.symmetric(horizontal: AppDimens.space14),
        ),
      ),
    );
  }
}
