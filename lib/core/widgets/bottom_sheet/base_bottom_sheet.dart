// Flutter imports:
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/header_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/buttons/bouncing_button.dart';
import 'package:car_tracking_app/core/widgets/textfields/rounded_textformfield_widget.dart';
import 'package:flutter/material.dart';

// Package imports:

import '../../constants/constants.dart';

class BaseBottomSheet<DATA> extends StatefulWidget {
  const BaseBottomSheet({
    super.key,
    this.textHeader,
    this.childContent,
    this.searchCondition,
    this.searchLabel,
    this.builder,
    this.padding,
    this.dataSource,
    this.withSearchField = true,
    this.withClear = false,
    this.withDone = false,
    this.doneLabel,
    this.bottom = true,
    this.isListView = true,
    this.onClear,
    this.onDone,
  })  : assert(
          childContent != null ||
              ((withSearchField == false && searchCondition == null) ||
                  (withSearchField && searchCondition != null)),
          'When search '
          'is on, you must provide a valid search condition',
        ),
        assert(
          (dataSource != null || childContent != null),
          'Can not be both null dataSource & childContent',
        );

  final bool Function(dynamic item, String searchQuery)? searchCondition;
  final Widget Function(
    dynamic data,
    void Function(VoidCallback fn) bottomSheetState,
  )? builder;
  final Function()? onClear;
  final Function()? onDone;

  final List<DATA> Function()? dataSource;
  final bool withSearchField;
  final bool withDone;
  final bool withClear;
  final bool isListView;
  final bool bottom;
  final String? doneLabel;
  final String? textHeader;
  final String? searchLabel;
  final Widget? childContent;
  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _BaseBottomSheetState<DATA>();
}

class _BaseBottomSheetState<DATA> extends State<BaseBottomSheet> {
  List<DATA> dataList = [];
  String searchStr = '';

  @override
  void initState() {
    super.initState();
    if (widget.dataSource != null) {
      dataList.addAll(widget.dataSource!() as List<DATA>);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = DeviceUtils.getScaledHeight(context, .9);
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height,
          maxWidth: double.infinity,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              AppRadius.bottomSheetBorderRadius,
            ),
          ),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: const EdgeInsets.only(
          top: AppDimens.space10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.textHeader != null)
              HeaderBottomSheet(title: widget.textHeader!),
            Flexible(child: _buildCurrentChild()),
            if (widget.withClear || widget.withDone)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.space24,
                  AppDimens.space24,
                  AppDimens.space24,
                  AppDimens.space24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.withClear)
                      Flexible(
                        child: BouncingButton(
                          onPressed: widget.onClear,
                          buttonStyle: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.black,
                            ),
                          ),
                          child: Text(
                            translate.clear,
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: AppColors.primaryGrayColor
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: AppDimens.space14,
                    ),
                    if (widget.withDone)
                      Flexible(
                        child: BouncingButton(
                          onPressed: widget.onDone,
                          child: Text(
                            widget.doneLabel ?? translate.done,
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: AppColors.primaryGrayColor
                            ),
                          ),
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

  Widget _buildList(String searchStr) {
    final List<DATA> filteredList =
        searchStr.isNotEmpty && widget.withSearchField
            ? dataList
                .where((element) => widget.searchCondition!(element, searchStr))
                .toList()
            : [
                ...dataList,
              ];
    return Flexible(
      child: StatefulBuilder(
        builder: (context, innerState) {
          if (!widget.isListView) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: filteredList
                    .map((e) => widget.builder!(e, innerState))
                    .toList(),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return widget.builder!(filteredList[index], innerState);
            },
          );
        },
      ),
    );
  }

  Widget _buildCurrentChild() {
    if (widget.childContent != null) {
      return Padding(
        padding: widget.padding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
            ),
        child: widget.childContent!,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.withSearchField)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
              vertical: AppDimens.space4,
            ),
            child: RoundedFormField(
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: AppColors.secondaryDarkGrayColor,
                ),
              ),
              hintText: widget.searchLabel ?? "",
              onChanged: (str) {
                setState(() {
                  searchStr = str;
                });
              },
            ),
          ),
        _buildList(searchStr),
        // VerticalTextPadding.with12(),
      ],
    );
  }
}
