import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';

class Helper {
  static final decoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.primaryGrey, width: 0.5),
  );

  static final hintStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    color: AppColors.primaryGrey,
    fontWeight: FontWeight.w400,
  );
}
