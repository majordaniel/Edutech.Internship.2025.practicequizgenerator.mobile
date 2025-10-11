import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';

class Helper {
  static final decoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: const Color.fromARGB(255, 230, 232, 237),
      width: 1,
    ),
  );

  static final hintStyle = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 12,
    color: AppColors.primaryGrey,
    fontWeight: FontWeight.w400,
  );
}
