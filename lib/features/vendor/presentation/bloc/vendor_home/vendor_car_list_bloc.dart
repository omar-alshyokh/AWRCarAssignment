import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/vendor/domain/repository/vendor_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'vendor_car_list_event.dart';

part 'vendor_car_list_state.dart';

@Injectable()
class VendorCarListBloc extends Bloc<VendorCarListEvent, VendorCarListState> {
  final VendorRepositoryImpl _repository;

  VendorCarListBloc(this._repository) : super(VendorCarListInitial()) {
    on<VendorLoadCars>(_mapToLoadCars);
  }

  void _mapToLoadCars(
    VendorLoadCars event,
    Emitter<VendorCarListState> emit,
  ) async {
    emit(VendorCarListLoading());

    await emit.forEach(
      /// fetch the only cars with pending (1) and delivering(2) status
      _repository.getListOfCarsAsStream(
        condition: QueryConditionModel(
            field: 'status',
            value: CarStatusType.delivered.value,
            operator: QueryConditionOperatorType.isLessThan),
      ),
      onData: (cars) => VendorCarListLoaded(cars: cars),
      onError: (e, s) {
        LoggerService().logError(e.toString(), e, s);
        return const VendorCarListError(
            error: CustomError(message: 'Failed to fetch cars.'));
      },
    );
  }
}
