import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wifi_List_Test_Task/core/styles/app_colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.lato(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );
  static final TextStyle subtitle = GoogleFonts.lato(
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );
  static final TextStyle networkItem = GoogleFonts.lato(
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );
  static final TextStyle refresh = GoogleFonts.lato(
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );
}
