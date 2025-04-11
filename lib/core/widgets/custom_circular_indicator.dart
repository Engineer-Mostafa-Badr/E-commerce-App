import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

class CustomCircularIndicator {
  static void showLoading() {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }

  static configLoading() async {
    return EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..maskType = EasyLoadingMaskType.black
      ..backgroundColor = Colors.white
      ..indicatorColor = const Color(0xFF5D9CEC)
      ..textColor = Colors.white
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
