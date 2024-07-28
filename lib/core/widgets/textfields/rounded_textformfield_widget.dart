import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double borderRadius;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool isEnableFocusOnTextField;
  final bool readOnly;
  final bool filled;
  final bool isDense;
  final Color? fillColor;
  final Function? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final Color? borderColor;
  final Color? cursorColor;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final GlobalKey? fieldKey;

  const RoundedFormField({
    super.key,
    this.fieldKey,
    this.validator,
    this.isEnableFocusOnTextField = true,
    this.inputFormat,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.onTap,
    this.readOnly = false,
    this.filled = true,
    this.isDense = false,
    this.fillColor,
    this.cursorColor,
    this.textAlign,
    this.maxLines = 1,
    this.minLines,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.textAlignVertical = TextAlignVertical.center,
    this.borderColor,
    this.textStyle,
    this.contentPadding,
    this.autofillHints,
    this.maxLength,
    this.buildCounter,
    this.hintStyle,
    this.hintText,
    this.helperText,
    this.borderRadius = AppRadius.radius12,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      minLines: minLines,
      scrollPhysics: const BouncingScrollPhysics(),
      scrollPadding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space2,
      ),
      style: textStyle ??
          appTextStyle.middleTSBasic.copyWith(
            color: AppColors.black,
            decorationThickness: 0,
            wordSpacing: 1.0,
          ),
      cursorColor: cursorColor ?? AppColors.secondaryDarkGrayColor,
      autofillHints: autofillHints,
      textCapitalization: TextCapitalization.sentences,
      cursorWidth: 1.5,
      maxLength: maxLength,
      // minLines: minLines??1,

      buildCounter: buildCounter,
      textAlignVertical: textAlignVertical,
      textAlign: textAlign ?? TextAlign.start,

      decoration: InputDecoration(
        isDense: isDense,
        errorMaxLines: 2,
        errorStyle: appTextStyle.smallTSBasic.copyWith(
          color: AppColors.primaryRedColor,
        ),
        counterStyle: appTextStyle.smallTSBasic.copyWith(
          color: AppColors.black,
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimens.space16,
              vertical: AppDimens.space12,
            ),
        focusedBorder: generalBoarder(
          borderRadius: borderRadius,
          borderColor:
          borderColor ?? AppColors.black,
        ),
        enabledBorder: generalBoarder(
          borderRadius: borderRadius,
          borderColor:
          borderColor ?? AppColors.black,
        ),
        errorBorder: generalBoarder(
          isError: true,
          borderRadius: borderRadius,
          borderColor:
          borderColor ??AppColors.primaryRedColor,
        ),
        border: generalBoarder(
          borderRadius: borderRadius,
          borderColor:
          borderColor ?? AppColors.black,
        ),
        focusedErrorBorder: generalBoarder(
          isError: true,
          borderRadius: borderRadius,
          borderColor:
          borderColor ?? AppColors.black,
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints ??
            const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
        suffixIconConstraints: suffixIconConstraints ??
            const BoxConstraints(
              minWidth: 20,
              minHeight:20,
            ),
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ??
            appTextStyle.middleTSBasic.copyWith(
              color: AppColors.primaryGrayColor,
            ),
        labelStyle: appTextStyle.middleTSBasic.copyWith(
          color: AppColors.black,
        ),
        filled: filled,
        alignLabelWithHint: true,
        fillColor: fillColor ?? AppColors.white,
        helperText: helperText,
      ),
      validator: validator,
      enabled: isEnableFocusOnTextField,
      inputFormatters: inputFormat,
      keyboardType: keyboardType,
      onChanged: onChanged,
      focusNode: focusNode,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap != null ? onTap as void Function()? : () {},
      onFieldSubmitted: onFieldSubmitted ??
              (term) {
            _fieldFocusChange(context, focusNode, nextNode);
          },
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

class RoundedPasswordFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? keyboardType;
  final double borderRadius;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool isEnableFocusOnTextField;
  final bool readOnly;
  final bool filled;
  final bool isDense;
  final Color? fillColor;
  final Function? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final Color? borderColor;
  final Color? cursorColor;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final GlobalKey? fieldKey;

  const RoundedPasswordFormField({
    super.key,
    this.fieldKey,
    this.validator,
    this.isEnableFocusOnTextField = true,
    this.inputFormat,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.onTap,
    this.readOnly = false,
    this.filled = true,
    this.isDense = false,
    this.fillColor,
    this.cursorColor,
    this.textAlign,
    this.maxLines = 1,
    this.minLines,
    this.onFieldSubmitted,
    this.hintColor,
    this.prefixIcon,
    this.autofillHints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.textAlignVertical = TextAlignVertical.center,
    this.borderColor,
    this.style,
    this.contentPadding,
    this.maxLength,
    this.buildCounter,
    this.hintStyle,
    required this.hintText,
    this.borderRadius = 0,
  });

  @override
  State<RoundedPasswordFormField> createState() =>
      _RoundedPasswordFormFieldState();
}

class _RoundedPasswordFormFieldState extends State<RoundedPasswordFormField> {
  bool isSecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      minLines: widget.minLines,
      key: widget.fieldKey,
      scrollPhysics: const BouncingScrollPhysics(),
      scrollPadding: const EdgeInsets.symmetric(horizontal: AppDimens.space2),
      style: widget.style ??
          appTextStyle.smallTSBasic.copyWith(
            color: AppColors.black,
            decorationThickness: 0,
            wordSpacing: 1.0,
          ),
      cursorColor: widget.cursorColor ?? AppColors.secondaryDarkGrayColor,
      textCapitalization: TextCapitalization.sentences,
      cursorWidth: 1.5,
      autofillHints: widget.autofillHints,
      maxLength: widget.maxLength,
      buildCounter: widget.buildCounter,
      textAlignVertical: widget.textAlignVertical,
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        isDense: widget.isDense,
        errorMaxLines: 2,
        errorStyle: appTextStyle.smallTSBasic.copyWith(
          color: AppColors.primaryRedColor,
        ),
        counterStyle: appTextStyle.smallTSBasic.copyWith(
          color: AppColors.secondaryDarkGrayColor,
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimens.space16,
              vertical: AppDimens.space12,
            ),
        focusedBorder: generalBoarder(
          borderRadius: widget.borderRadius,
          borderColor: widget.borderColor ??
              AppColors.black,
        ),
        enabledBorder: generalBoarder(
          borderRadius: widget.borderRadius,
          borderColor: widget.borderColor ??
              AppColors.black,
        ),
        errorBorder: generalBoarder(
          isError: true,
          borderRadius: widget.borderRadius,
          borderColor:
          widget.borderColor ?? AppColors.primaryRedColor,
        ),
        border: generalBoarder(
          borderRadius: widget.borderRadius,
          borderColor: widget.borderColor ??
              AppColors.black,
        ),
        focusedErrorBorder: generalBoarder(
          isError: true,
          borderRadius: widget.borderRadius,
          borderColor: widget.borderColor ??
              AppColors.black,
        ),
        hintText: widget.hintText,
        // labelText: widget.labelText??'',
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints ??
            const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
        suffixIconConstraints: widget.suffixIconConstraints ??
            const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
        hintStyle: widget.hintStyle ??
            appTextStyle.middleTSBasic.copyWith(
              color: AppColors.primaryGrayColor,
            ),
        labelStyle: appTextStyle.middleTSBasic.copyWith(
          color: AppColors.black,
        ),
        filled: widget.filled,
        fillColor:
        widget.fillColor ?? AppColors.white,
        suffixIcon: widget.suffixIcon ??
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (mounted) {
                  setState(() {
                    isSecureText = !isSecureText;
                  });
                }
              },
              icon: Icon(
                 isSecureText
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.secondaryDarkGrayColor,
                size: 14
              ),
            ),
      ),
      validator: widget.validator,
      enabled: widget.isEnableFocusOnTextField,
      inputFormatters: widget.inputFormat,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      obscureText: isSecureText,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      onTap: widget.onTap != null ? widget.onTap as void Function()? : () {},
      onFieldSubmitted: widget.onFieldSubmitted ??
              (term) {
            _fieldFocusChange(context, widget.focusNode, widget.nextNode);
          },
    );
  }

  _fieldFocusChange(
      BuildContext context,
      FocusNode? currentFocus,
      FocusNode? nextFocus,
      ) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

InputBorder generalBoarder({
  bool isError = false,
  required double borderRadius,
  Color? borderColor,
}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: borderColor ?? AppColors.black,
      style: BorderStyle.solid,
      width: isError ? 1.5 : 1,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(AppRadius.radius12),
    ),
  );
}
