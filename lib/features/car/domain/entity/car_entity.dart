// Project imports:
import 'dart:ui';

import 'package:car_tracking_app/core/entity/base_entity.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarEntity extends BaseEntity {
  final String id;
  final String name;

  final String? brandName;
  final String? imageUrl;
  final String? currentKm;
  final String? totalKm;
  final double pickUpLocationLatitude;
  final double pickUpLocationLongitude;
  final double dropOffLocationLatitude;
  final double dropOffLocationLongitude;
  final double currentLocationLatitude;
  final double currentLocationLongitude;

  final Timestamp? pickUpTime;

  final Timestamp? dropOffTime;
  final Timestamp? createdAt;

  final String? vendorUserName;
  final String? vendorContactNumber;
  final String carPlate;
  final String? modelYear;
  final int status;

  const CarEntity(
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
        return Colors.orange;
      case 2: // Delivering
        return Colors.blue;
      case 3: // Delivered
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
