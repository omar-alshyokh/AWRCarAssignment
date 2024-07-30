import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';

import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';

import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/bloc/car_bloc.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_item_widget.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/empty_car_list.dart';
import 'package:car_tracking_app/features/home/domain/entity/filter_item_entity.dart';
import 'package:car_tracking_app/features/home/presentation/widgets/home_filter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends BaseAppStatefulWidget {
  const HomePage({super.key});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() => _HomePageState();
}

class _HomePageState extends BaseAppState<HomePage> {
  late final CarBloc carBloc;

  final List<CarEntity> _carList = [];
  final List<CarEntity> _filterCarList = [];

  List<FilterItemEntity> _filterItems = [];
  FilterItemEntity? _selectedItem;
  int _selectedFilterIndex = 0;


  GlobalKey parentWidgetKey = GlobalKey();
  late AppLanguage languageManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    languageManager = context.watch<AppLanguage>();
    _initFilterList();
  }

  _initFilterList() {
    _filterItems = [
      FilterItemEntity(statusType: null, label: translate.all),
      FilterItemEntity(
          statusType: CarStatusType.pending.value, label: translate.pending),
      FilterItemEntity(
          statusType: CarStatusType.delivering.value,
          label: translate.delivering),
      FilterItemEntity(
          statusType: CarStatusType.delivered.value,
          label: translate.delivered),
    ];

    _selectedItem = _filterItems.first;
  }

  @override
  void initState() {
    super.initState();
    _initFilterList();

    carBloc = findDep<CarBloc>();
    carBloc.add(GetCarsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);

    final double height = DeviceUtils.getScaledHeight(context, 1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark),
        toolbarHeight: 0,
      ),
      body: BlocConsumer<CarBloc, CarState>(
        bloc: carBloc,
        listener: (context, state) {
          if (state is GetCarsSuccess) {
            if (mounted) {
              _carList.clear();
              _carList.addAll(state.cars);
              _getItemsList(type: _selectedItem?.statusType);
              setState(() {});
            }
          } else if (state is GetCarsFailed) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              /// logo
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: ZoomIn(
                  child: Image.asset(
                    AppAssets.appLogo,
                    height: 65,
                  ),
                ),
              ),

              _body(width: width, state: state, height: height),
              if (state is CarLoading)
                const Center(
                    child: AppLoader(
                  iconColor: AppColors.primaryOrangeColor,
                ))
            ],
          );
        },
      ),
    );
  }

  Widget _body(
      {required CarState state,
      required double height,
      required double width}) {
    if (state is CarLoading) {
      if (_carList.isEmpty) {
        return const SizedBox();
      } else {
        return _contentBody(width: width, height: height);
      }
    } else if (state is GetCarsSuccess) {
      if (_carList.isEmpty) return const EmptyCarList();
      return _contentBody(width: width, height: height);
    }
    return const SizedBox();
  }

  Widget _contentBody({required double height, required double width}) {
    return SizedBox(
      height: height,
      // color: AppColors.primaryGrayColor,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 65,
                color: AppColors.transparent,
              ),
              Container(
                height: 32,
                // color: AppColors.white,
                margin: const EdgeInsets.only(bottom: 2),
                child: _filterHorizontalList(),
              ),
              Expanded(
                key: parentWidgetKey,
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: _filterCarList.length,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: EdgeInsets.only(
                        left: AppDimens.space16,
                        right: AppDimens.space16,
                        top: AppDimens.space16,
                        bottom: height * .2),
                    itemBuilder: (context, index) {
                      CarEntity car = _filterCarList[index];
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(
                              milliseconds: AppDurations.animationDuration_666),
                          child: SlideAnimation(
                              verticalOffset: 70.0,
                              child: FadeInAnimation(
                                  child: AppInkWellWidget(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.carDetailsPage,
                                            arguments: car);
                                      },
                                      child: CarItemWidget(car: car)))));
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: height * .1,
            child: _mapOverViewButton(width),
          )
        ],
      ),
    );
  }

  Widget _mapOverViewButton(double width) {
    return Container(
      width: width,
      height: 45,
      alignment: AlignmentDirectional.center,
      child: CustomElevatedButton(
        borderRadius: AppRadius.radius8,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.mapLocationsOverviewPage);
        },
        backgroundColor: AppColors.secondaryDarkGrayColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.space4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.map_outlined,
                color: AppColors.white,
                size: 18,
              ),
              const SizedBox(
                width: AppDimens.space6,
              ),
              Text(
                translate.map_overview,
                style: appTextStyle.middleTSBasic.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// filter list
  Widget _filterHorizontalList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return HomeFilterItemWidget(
          filterItem: _filterItems[index],
          isSelected:
              _selectedItem?.statusType == _filterItems[index].statusType,
          onSelect: () {
            _selectedFilterIndex = index;
            _selectedItem = _filterItems[_selectedFilterIndex];
            parentWidgetKey = GlobalKey();
            _getItemsList(type: _selectedItem?.statusType);
            if (mounted) {
              setState(() {});
            }

            /// flashing an event for car list filter action
            eventTracker(event: ButtonAnalyticIdentity.carListFilter);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: AppDimens.space8,
        );
      },
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      itemCount: _filterItems.length,
      scrollDirection: Axis.horizontal,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      shrinkWrap: true,
    );
  }

  _getItemsList({int? type}) {
    if (type == CarStatusType.pending.value) {
      /// get all pending items
      _filterCarList.clear();
      _filterCarList.addAll(_carList
          .where((element) => element.status == CarStatusType.pending.value));
    } else if (type == CarStatusType.delivering.value) {
      /// get all pending items
      _filterCarList.clear();
      _filterCarList.addAll(_carList.where(
          (element) => element.status == CarStatusType.delivering.value));
    } else if (type == CarStatusType.delivered.value) {
      /// get all pending items
      _filterCarList.clear();
      _filterCarList.addAll(_carList
          .where((element) => element.status == CarStatusType.delivered.value));
    } else {
      /// get all items
      _filterCarList.clear();
      _filterCarList.addAll(_carList);
    }
  }

  @override
  void dispose() {
    carBloc.close();
    super.dispose();
  }
}
