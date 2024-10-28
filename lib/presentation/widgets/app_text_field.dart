import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.prefix,
    this.inputFormatters,
    this.suffix,
    this.borderColor,
    this.bgColor,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.keyboardType,
    this.padding,
    this.onTap,
    this.textColor,
    this.readOnly,
  });

  final TextEditingController controller;
  final String placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final Color? borderColor;
  final Color? bgColor;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      cursorColor: AppColors.surface,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.top,
      suffix: suffix,
      prefix: prefix,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      placeholder: placeholder,
      placeholderStyle: AppTextStyle.bodyMedium
          .copyWith(color: AppColors.surface.withOpacity(0.5)),
      onChanged: onChanged,
      padding: padding ?? const EdgeInsets.all(15),
      style: AppTextStyle.bodyMedium,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(width: 2, color: AppColors.outline4),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
