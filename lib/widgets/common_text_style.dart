import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

Widget commonVerticalDivider() {
  return VerticalDivider(
    color: Get.isDarkMode ? servpalPrimaryColor : onClocGreyColor,
    thickness: 1.5,
    indent: 4,
  );
}

InputDecoration commonDecoration(ThemeData theme, String labelText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(bottom: 5),
    labelText: labelText,
    hintText: labelText,
    filled: true,
    fillColor: Colors.transparent,
    hintStyle: theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w300,
      color: Get.isDarkMode ? Colors.white : onClocGreyColor,
    ),
    floatingLabelStyle: theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w300,
      color: Get.isDarkMode ? Colors.white : onClocGreyColor,
    ),
    labelStyle: theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w300,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: onClocGreyColor.withValues(alpha: 0.10),
      ), // Underline color when focused
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: onClocGreyColor.withValues(alpha: 0.10),
      ), // Underline color when focused
    ),
  );
}
