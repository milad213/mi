import 'package:flutter/material.dart';

import 'color_manager.dart';

TextTheme get textTheme => TextTheme(
  displayLarge: TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: ColorManager.white,
  ),
  displayMedium: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  ),
  displaySmall: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: ColorManager.black,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorManager.black,
  ),
  labelLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorManager.black,
  ),
  bodyLarge: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: ColorManager.black,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: ColorManager.grey,
  ),
);
