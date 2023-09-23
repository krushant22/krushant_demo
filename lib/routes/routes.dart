import 'package:get/get.dart';
import 'package:krushant_demo/utills/commono_binding.dart';
import 'package:krushant_demo/view/authantication/login/login_screen.dart';
import 'package:krushant_demo/view/edit_details/edit_details_screen.dart';
import 'package:krushant_demo/view/home/home_screen.dart';
import 'package:krushant_demo/view/splash/splash_screen.dart';

class ApplicationRoutes {
  static const String initialRoutes = "/";
  static const String loginScreen = "/loginScreen";
  static const String homeScreen = "/homeScreen";
  static const String editDetails = "/editDetails";

  static List<GetPage<dynamic>> get generateRoutes => [
        GetPage(
            name: initialRoutes,
            page: () => const SplashScreen(),
            binding: CommonBinding()),
        GetPage(
            name: loginScreen,
            page: () => LoginScreen(),
            binding: CommonBinding()),
        GetPage(
            name: homeScreen,
            page: () => const HomeScreen(),
            binding: CommonBinding()),
        GetPage(
            name: editDetails,
            page: () => const EditDetailScreen(),
            binding: CommonBinding()),
      ];
}
