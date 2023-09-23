import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/theme/color/colors.dart';

class LoginController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxBool isRememberMe = false.obs;

  checkRememberMe() {
    isRememberMe.value = !isRememberMe.value;
    refresh();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget passwordShowHideWidget() {
    if (isPasswordVisible.isTrue) {
      return IconButton(
          onPressed: () {
            isPasswordVisible.value = false;
            refresh();
          },
          icon: const Icon(
            Icons.remove_red_eye_outlined,
            color: textFieldBorderColor,
          ));
    } else {
      return IconButton(
          onPressed: () {
            isPasswordVisible.value = true;
            refresh();
          },
          icon: const Icon(
            Icons.visibility_off_outlined,
            color: textFieldBorderColor,
          ));
    }
  }

  bool matchCredential(String email, String password) {
    return email == "krushant@gmail.com" && password == "Krushant@123";
  }
}
