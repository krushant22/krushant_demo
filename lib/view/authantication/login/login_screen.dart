import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krushant_demo/model/user_responce.dart';
import 'package:krushant_demo/routes/routes.dart';
import 'package:krushant_demo/theme/color/colors.dart';
import 'package:krushant_demo/utills/common_image_path.dart';
import 'package:krushant_demo/utills/session/sessionhelper.dart';
import 'package:krushant_demo/view/authantication/login/login_controller.dart';
import 'package:krushant_demo/view/components/my_form_field.dart';
import 'package:krushant_demo/view/components/my_regular_text.dart';
import 'package:krushant_demo/view/components/my_theme_button.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // minimum: const EdgeInsets.all(16.0).copyWith(bottom: 0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Container(
                height: context.height * 0.44,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(loginBackground), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: context.height * 0.04,
                      width: context.height * 0.1,
                      height: context.height * 0.24,
                      child: Container(
                        decoration: const BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage(mainLight))),
                      ),
                    ),
                    Positioned(
                      left: context.height * 0.2,
                      width: context.height * 0.1,
                      height: context.height * 0.18,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(secoundryLight))),
                      ),
                    ),
                    Positioned(
                      right: context.height * 0.04,
                      top: context.height * 0.04,
                      width: context.height * 0.08,
                      height: context.height * 0.18,
                      child: Container(
                        decoration: const BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage(loginClock))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: boxShadow,
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]!))),
                            child: TextField(
                              controller: controller.emailTextEditingController,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() {
                              return TextField(
                                controller:
                                    controller.passwordTextEditingController,
                                obscureText: controller.isPasswordVisible.value,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  suffixIcon:
                                      controller.passwordShowHideWidget(),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.016,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const MyRegularText(
                          label: "Remember Me",
                          color: buttonSecondColor,
                        ),
                        Obx(() {
                          return Checkbox.adaptive(
                            checkColor: buttonFirstColor,
                            activeColor: buttonSecondColor,
                            hoverColor: buttonSecondColor,
                            value: controller.isRememberMe.value,
                            onChanged: (value) {
                              controller.checkRememberMe();
                            },
                          );
                        })
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.016,
                    ),
                    MyThemeButton(
                      buttonText: "Login",
                      onPressed: () async {
                        if (controller
                            .emailTextEditingController.text.isEmpty) {
                          Get.snackbar("Error", "Email is required",
                              colorText: red);
                        } else if (controller
                            .passwordTextEditingController.text.isEmpty) {
                          Get.snackbar("Error", "Password is required",
                              colorText: red);
                        } else if (controller.matchCredential(
                            controller.emailTextEditingController.text,
                            controller.passwordTextEditingController.text)) {
                          if (controller.isRememberMe.isTrue) {
                            SessionHelper.loginSavedData = await SessionHelper()
                                .setLoginData(UserResponse(
                                    email: controller
                                        .emailTextEditingController.text,
                                    password: controller
                                        .passwordTextEditingController.text,
                                    userName: "Krushant Prabtani",
                                    userImagePath: null,
                                    skills: [
                                      "Android-Iso Application Development",
                                      "Flutter",
                                      "Dart Programming",
                                      "Java Programming"
                                    ],
                                    workExpirience:
                                        "1.7 Year (Feb 2022 - Present)"));
                          } else {
                            SessionHelper.loginSavedData = UserResponse(
                                email:
                                    controller.emailTextEditingController.text,
                                password: controller
                                    .passwordTextEditingController.text,
                                userName: "Krushant Prabtani",
                                userImagePath: null,
                                skills: [
                                  "Android-Iso Application Development",
                                  "Flutter",
                                  "Dart Programming",
                                  "Java Programming"
                                ],
                                workExpirience:
                                    "1.7 Year (Feb 2022 - Present)");
                          }

                          Get.offNamedUntil(
                            ApplicationRoutes.homeScreen,
                            (route) => false,
                          );
                        } else {
                          Get.snackbar("Error", "Invalid Email or Password",
                              colorText: red);
                        }
                      },
                    ),
                    SizedBox(
                      height: context.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: context.height * 0.03),
                      child: SignInButton(
                        Buttons.Google,
                        elevation: 0,
                        onPressed: () {
                          signInWithGoogle();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    if (googleSignInAuthentication != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        SessionHelper.loginSavedData =
            await SessionHelper().setLoginData(UserResponse(
                email: value.user!.email,
                password: value.user!.uid,
                userName: value.user!.displayName,
                userImagePath: value.user!.photoURL,
                skills: [
                  "Android-Iso Application Development",
                  "Flutter",
                  "Dart Programming",
                  "Java Programming",
                  "Kotlin Programming"
                ],
                workExpirience: "1.7 Year (Feb 2022 - Present)"));
        Get.offNamedUntil(
          ApplicationRoutes.homeScreen,
          (route) => false,
        );
      });
      _user = _auth.currentUser!;
    }
  }
}
