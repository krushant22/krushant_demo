import 'package:get/get.dart';
import 'package:krushant_demo/view/authantication/login/login_controller.dart';
import 'package:krushant_demo/view/edit_details/edit_details_controller.dart';
import 'package:krushant_demo/view/splash/splash_controller.dart';

class CommonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => EditDetailsController());
  }
}
