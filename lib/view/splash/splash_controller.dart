import 'package:get/get.dart';
import 'package:krushant_demo/routes/routes.dart';
import 'package:krushant_demo/utills/session/sessionhelper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  void _startTimer() => Future.delayed(
        const Duration(seconds: 6),
        () {
          SessionHelper().getLoginData().then((value) {
            if (value != null) {
              SessionHelper.loginSavedData = value;
              Get.offNamedUntil(ApplicationRoutes.homeScreen, (route) => false);
            } else {
              Get.offNamedUntil(ApplicationRoutes.loginScreen, (route) => false);
            }
          });
        },
      );
}
