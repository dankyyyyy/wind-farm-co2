import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double? adjustedScreenHeight = SizeConfig.screenHeight;
  return (inputHeight / 891.42) * adjustedScreenHeight!;
}

double? getProportionateScreenWidth(double inputWidth) {
  double? adjustedScreenWidth = SizeConfig.screenWidth;
  return (inputWidth / 411.42) * adjustedScreenWidth!;
}
