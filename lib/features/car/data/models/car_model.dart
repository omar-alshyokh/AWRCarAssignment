import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:car_tracking_app/core/utils/timestamp_json_converter.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'car_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class CarModel extends BaseModel<CarEntity> {
  final String id;
  final String name;

  @JsonKey(name: "brand_name")
  final String? brandName;
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @JsonKey(name: "current_km")
  final String? currentKm;
  @JsonKey(name: "total_km")
  final String? totalKm;
  @JsonKey(name: "pick_up_location_latitude")
  final double pickUpLocationLatitude;
  @JsonKey(name: "pick_up_location_longitude")
  final double pickUpLocationLongitude;
  @JsonKey(name: "drop_off_location_latitude")
  final double dropOffLocationLatitude;
  @JsonKey(name: "drop_off_location_longitude")
  final double dropOffLocationLongitude;
  @JsonKey(name: "current_location_latitude")
  final double currentLocationLatitude;
  @JsonKey(name: "current_location_longitude")
  final double currentLocationLongitude;
  @JsonKey(
      name: "pick_up_time",
      fromJson: TimestampConverter.fromJson,
      toJson: TimestampConverter.toJson,  required: false)
  final Timestamp? pickUpTime;

  @JsonKey(
      name: "created_at",
      fromJson: TimestampConverter.fromJson,
      toJson: TimestampConverter.toJson,  required: false)
  final Timestamp? createdAt;

  @JsonKey(
      name: "drop_off_time",
      fromJson: TimestampConverter.fromJson,
      toJson: TimestampConverter.toJson,
  required: false
  )
  final Timestamp? dropOffTime;

  @JsonKey(name: "vendor_user_name")
  final String? vendorUserName;
  @JsonKey(name: "vendor_contact_number")
  final String? vendorContactNumber;
  @JsonKey(name: "car_plate")
  final String carPlate;
  @JsonKey(name: "model_year")
  final String? modelYear;

  /// which represent
  /// 1 -> pending
  /// 2 -> delivering
  /// 3 -> delivered
  @JsonKey(name: "status")
  final int status;

  CarModel(
      {required this.id,
      required this.name,
      this.brandName,
      this.imageUrl,
      this.currentKm,
      required this.pickUpLocationLatitude,
      required this.pickUpLocationLongitude,
      required this.dropOffLocationLatitude,
      required this.dropOffLocationLongitude,
      required this.currentLocationLatitude,
      required this.currentLocationLongitude,
      this.pickUpTime,
      this.dropOffTime,
      this.createdAt,
      this.totalKm,
      this.vendorUserName,
      this.vendorContactNumber,
      required this.carPlate,
      this.modelYear,
      required this.status});

  /// Connect the generated [_$CarModelFromJson] function to the `fromJson`
  /// factory.
  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  /// Connect the generated [_$CarModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarModelToJson(this);

  @override
  CarEntity toEntity() {
    return CarEntity(
      currentLocationLatitude: currentLocationLatitude,
      currentLocationLongitude: currentLocationLongitude,
      dropOffLocationLatitude: dropOffLocationLatitude,
      dropOffLocationLongitude: dropOffLocationLongitude,
      dropOffTime: dropOffTime,
      id: id,
      carPlate: carPlate,
      name: name,
      pickUpLocationLatitude: pickUpLocationLatitude,
      pickUpLocationLongitude: pickUpLocationLongitude,
      pickUpTime: pickUpTime,
      status: status,
      brandName: brandName,
      currentKm: currentKm,
      imageUrl: imageUrl,
      modelYear: modelYear,
      totalKm: totalKm,
      vendorContactNumber: vendorContactNumber,
      vendorUserName: vendorUserName,
      createdAt: createdAt,
    );
  }
}
