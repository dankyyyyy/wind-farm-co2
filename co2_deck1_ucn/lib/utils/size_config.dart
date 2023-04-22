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

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double? adjustedScreenHeight = SizeConfig.screenHeight;
// 812 is the layout height that designer use
  return (inputHeight / 891.42) * adjustedScreenHeight!;
}

// Get the proportionate width as per screen size
double? getProportionateScreenWidth(double inputWidth) {
  double? adjustedScreenWidth = SizeConfig.screenWidth;
// 375 is the layout width that designer use
  return (inputWidth / 411.42) * adjustedScreenWidth!;
}
