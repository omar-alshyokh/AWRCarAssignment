import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/features/home/domain/entity/filter_item_entity.dart';
import 'package:flutter/material.dart';

class HomeFilterItemWidget extends StatelessWidget {
  final bool isSelected;
  final FilterItemEntity filterItem;
  final VoidCallback onSelect;

  const HomeFilterItemWidget(
      {super.key,
      required this.filterItem,
      this.isSelected = false,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: SizedBox(
        height: 32,
        child: Stack(
          children: [
            if (isSelected)
              ZoomIn(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 84,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryDarkGrayColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.radius8)),
                  ),
                  padding: const EdgeInsets.all(AppDimens.space8),
                ),
              ),
            Container(
              height: 32,
              width: 84,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.transparent : AppColors.lightGray,
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.radius8)),
              ),
              padding: const EdgeInsets.all(AppDimens.space8),
              child: Center(
                child: Text(
                  filterItem.label,
                  style: appTextStyle.smallTSBasic.copyWith(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.primaryGrayColor,
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
