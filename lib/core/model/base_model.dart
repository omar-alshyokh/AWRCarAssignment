// Project imports:

import 'package:car_tracking_app/core/entity/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  const BaseModel();

  T toEntity();
}
