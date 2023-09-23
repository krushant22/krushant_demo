import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/view/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Image.network("https://mir-s3-cdn-cf.behance.net/project_modules/disp/20f0cd40760693.578c9a46841f5.gif")),
      ),
    );
  }
}
