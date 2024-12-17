import 'package:flutter/material.dart';
import 'package:wifi_List_Test_Task/core/styles/app_colors.dart';
import 'package:wifi_List_Test_Task/core/styles/app_sizes.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';

class AppTheme {
  static final main = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.radius)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.radius)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.radius)),
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.radius)),
        gapPadding: 0,
        borderSide: BorderSide(color: AppColors.grey),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.radius)),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      hintStyle: AppTextStyles.textHelper,
      labelStyle: AppTextStyles.textHelper,
      errorStyle: const TextStyle(height: 0),
    ),
  );
}
