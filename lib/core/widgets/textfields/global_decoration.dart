import 'package:flutter/material.dart';

import '../../constants/constants.dart';


abstract class GlobalDecorations {
  static InputDecoration get kNormalFieldInputDecoration => InputDecoration(
      labelStyle: appTextStyle.smallTSBasic.copyWith(color: AppColors.black),
      errorStyle: appTextStyle.subMinTSBasic.copyWith(
        color: Colors.red,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGray),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGray),
      )
  );

  static InputDecoration get normalFieldUerManagementNInputDecoration =>
      InputDecoration(
        hintStyle: const TextStyle(color: AppColors.lightGray),
        alignLabelWithHint: true,
        fillColor: AppColors.white,
        filled: true,
        labelStyle: appTextStyle.smallTSBasic.copyWith(color: AppColors.black),
        errorStyle: appTextStyle.subMinTSBasic.copyWith(
          color: Colors.red,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius16)),
          borderSide: BorderSide(color: AppColors.white),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppRadius.radius16),
          ),
        ),
      );

  static InputDecoration get kBorderFieldInputDecoration => InputDecoration(
    alignLabelWithHint: false,
    labelStyle: appTextStyle.normalTSBasic,
    errorStyle: appTextStyle.subMinTSBasic.copyWith(
      color: Colors.red,
    ),
    filled: false,
  );

  static InputDecoration get underLineVerificationCOdeFieldInputDecoration =>
      InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        filled: false,
        errorStyle: appTextStyle.middleTSBasic.copyWith(
          color: Colors.red,
        ),
      );

  static InputBorder generalBoarder(
      {bool isError = false, required double borderRadius, Color? borderColor,bool isFocus = false}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: isFocus ? AppColors.black : borderColor ?? AppColors.lightGray,
        style: BorderStyle.solid,
        width:isFocus ? 1.0 : isError ? 1.5 : 0.5,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(borderRadius) //         <--- border radius here
      ),
    );
  }
}