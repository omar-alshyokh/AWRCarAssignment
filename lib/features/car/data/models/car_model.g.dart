// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map json) => CarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brandName: json['brand_name'] as String?,
      imageUrl: json['image_url'] as String?,
      currentKm: json['current_km'] as String?,
      pickUpLocationLatitude:
          (json['pick_up_location_latitude'] as num).toDouble(),
      pickUpLocationLongitude:
          (json['pick_up_location_longitude'] as num).toDouble(),
      dropOffLocationLatitude:
          (json['drop_off_location_latitude'] as num).toDouble(),
      dropOffLocationLongitude:
          (json['drop_off_location_longitude'] as num).toDouble(),
      currentLocationLatitude:
          (json['current_location_latitude'] as num).toDouble(),
      currentLocationLongitude:
          (json['current_location_longitude'] as num).toDouble(),
      pickUpTime: TimestampConverter.fromJson(json['pick_up_time']),
      dropOffTime: TimestampConverter.fromJson(json['drop_off_time']),
      createdAt: TimestampConverter.fromJson(json['created_at']),
      totalKm: json['total_km'] as String?,
      vendorUserName: json['vendor_user_name'] as String?,
      vendorContactNumber: json['vendor_contact_number'] as String?,
      carPlate: json['car_plate'] as String,
      modelYear: json['model_year'] as String?,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand_name': instance.brandName,
      'image_url': instance.imageUrl,
      'current_km': instance.currentKm,
      'total_km': instance.totalKm,
      'pick_up_location_latitude': instance.pickUpLocationLatitude,
      'pick_up_location_longitude': instance.pickUpLocationLongitude,
      'drop_off_location_latitude': instance.dropOffLocationLatitude,
      'drop_off_location_longitude': instance.dropOffLocationLongitude,
      'current_location_latitude': instance.currentLocationLatitude,
      'current_location_longitude': instance.currentLocationLongitude,
      'pick_up_time': TimestampConverter.toJson(instance.pickUpTime),
      'created_at': TimestampConverter.toJson(instance.createdAt),
      'drop_off_time': TimestampConverter.toJson(instance.dropOffTime),
      'vendor_user_name': instance.vendorUserName,
      'vendor_contact_number': instance.vendorContactNumber,
      'car_plate': instance.carPlate,
      'model_year': instance.modelYear,
      'status': instance.status,
    };
