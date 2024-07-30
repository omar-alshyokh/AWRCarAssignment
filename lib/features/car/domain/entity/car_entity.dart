// Project imports:
import 'dart:ui';

import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/entity/base_entity.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum CarStatusType {

  pending(1),
  delivering(2),
  delivered(3);

  // can add more properties or getters/methods if needed
  final int value;

  const CarStatusType(this.value);
}

class CarEntity extends BaseEntity {
  final String id;
  final String name;

  final String? brandName;
  final String? imageUrl;
  final String? currentKm;
  String? totalKm;
  final double pickUpLocationLatitude;
  final double pickUpLocationLongitude;
  final double dropOffLocationLatitude;
  final double dropOffLocationLongitude;
   double currentLocationLatitude;
   double currentLocationLongitude;

  Timestamp? pickUpTime;

  Timestamp? dropOffTime;
  final Timestamp? createdAt;

  String? vendorUserName;
  String? vendorContactNumber;
  final String carPlate;
  final String? modelYear;
  int status;

  CarEntity(
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

  @override
  List<Object?> get props => [
        id,
        name,
        brandName,
        imageUrl,
        currentKm,
        pickUpLocationLatitude,
        pickUpLocationLongitude,
        dropOffLocationLatitude,
        dropOffLocationLongitude,
        currentLocationLatitude,
        currentLocationLongitude,
        pickUpTime,
        dropOffTime,
        createdAt,
        totalKm,
        vendorUserName,
        vendorContactNumber,
        carPlate,
        modelYear,
        status
      ];

  String get statusText {
    switch (status) {
      case 1: // Pending
        return translate.pending;
      case 2: // Delivering
        return translate.delivering;
      case 3: // Delivered
        return translate.delivered;
      default:
        return translate.unknown;
    }
  }

  String get statusTextMessage {
    switch (status) {
      case 1: // Pending
        return translate.pending_message;
      case 2: // Delivering
        return translate.delivering_message;
      case 3: // Delivered
        return translate.delivered_message;
      default:
        return translate.unknown_message;
    }
  }

  Color get statusColor {
    switch (status) {
      case 1: // Pending
        return AppColors.primaryOrangeColor;
      case 2: // Delivering
        return AppColors.blue;
      case 3: // Delivered
        return AppColors.green;
      default:
        return AppColors.primaryGrayColor;
    }
  }

  CarModel toCarModel() {
    return CarModel(
        id: id,
        name: name,
        pickUpLocationLatitude: pickUpLocationLatitude,
        pickUpLocationLongitude: pickUpLocationLongitude,
        dropOffLocationLatitude: dropOffLocationLatitude,
        dropOffLocationLongitude: dropOffLocationLongitude,
        currentLocationLatitude: currentLocationLatitude,
        currentLocationLongitude: currentLocationLongitude,
        carPlate: carPlate,
        brandName: brandName,
        createdAt: createdAt,
        currentKm: currentKm,
        dropOffTime: dropOffTime,
        imageUrl: imageUrl,
        modelYear: modelYear,
        pickUpTime: pickUpTime,
        totalKm: totalKm,
        vendorContactNumber: vendorContactNumber,
        vendorUserName: vendorUserName,
        status: status);
  }
}
