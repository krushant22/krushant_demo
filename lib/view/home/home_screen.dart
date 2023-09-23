import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/routes/routes.dart';
import 'package:krushant_demo/theme/color/colors.dart';
import 'package:krushant_demo/utills/session/sessionhelper.dart';
import 'package:krushant_demo/utills/session/sessionmanager.dart';
import 'package:krushant_demo/view/components/my_regular_text.dart';
import 'package:krushant_demo/view/components/my_theme_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    print('data++ ${ SessionHelper.loginSavedData?.email}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(child: mainWidget(context)),
    ));
  }

  Widget mainWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:  context.height * 0.02,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                MyRegularText(label: "My Profile", fontSize: 26, color: buttonFirstColor),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: IconButton.filledTonal(
                    onPressed: () {
                      showAlertDialog(context: context, text: 'Logout');
                    },
                    icon: const Icon(Icons.logout))),
          ],
        ),

        SizedBox(
          height: context.height * 0.04,
        ),
        profileImageWidget(context),
        SizedBox(
          height: context.height * 0.04,
        ),
        Container(
          padding:EdgeInsets.all(  context.height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  buttonFirstColor,
                  buttonSecondColor
                ]
              )
            ),
            child: basicDetails(context)),

        SizedBox(
          height: context.height * 0.06,
        ),
        MyThemeButton(
            buttonText: "Edit Details",
            onPressed: () {
              Get.toNamed(ApplicationRoutes.editDetails)?.whenComplete(() {
                setState(() {
                  SessionHelper.loginSavedData;
                });
              });
            }),
      ],
    );
  }

  Widget basicDetails(BuildContext context) {
    return Column(
      children: [
        detailComponent("User Name",
            SessionHelper.loginSavedData!.userName.toString(), context),
        SizedBox(
          height: context.height * 0.02,
        ),
        detailComponent(
            "Email", SessionHelper.loginSavedData!.email.toString(), context),
        SizedBox(
          height: context.height * 0.02,
        ),
        detailComponent("Work Experience",
            SessionHelper.loginSavedData!.workExpirience.toString(), context),
        SizedBox(
          height: context.height * 0.02,
        ),
        skillsWidget(context),

      ],
    );
  }

  Widget skillsWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRegularText(
          label: "Skills: ",
          fontSize: 16,
          color: white,
        ),
        SizedBox(width:   context.width * 0.02, ),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List<Widget>.generate(
                SessionHelper.loginSavedData!.skills!.length,
                (index) => Card(
                  color: white,
                      elevation: 3,
                      margin: index == 0 ? EdgeInsets.zero : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyRegularText(
                            label: SessionHelper.loginSavedData!.skills![index],
                            fontSize: 14,
                            color: primaryTextColor),
                      ),
                    )),
          ),
        )
      ],
    );
  }

  Widget detailComponent(String labelName, String mainName, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyRegularText(
          label: "$labelName: ",
          fontSize: 16,
          color: white,
        ),
        SizedBox(
          width: context.width * 0.02,
        ),
        Flexible(
          child: MyRegularText(
            maxlines: mainName.length,
            label: "${mainName}",
            fontSize: 16,
            color: black,
          ),
        ),
      ],
    );
  }

  Widget profileImageWidget(BuildContext context) {
    return Center(
      child: Hero(
        tag: "ImgKrushant",
        child: SizedBox(
            height: context.height * 0.16,
            width: context.height * 0.16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.height * 0.16),
              child: GetUtils.isURL(SessionHelper.loginSavedData!.userImagePath.toString())
                  ? Image.network(
                      SessionHelper.loginSavedData!.userImagePath!,
                      fit: BoxFit.cover,
                    )
                  : SessionHelper.loginSavedData!.userImagePath != null &&
                          SessionHelper.loginSavedData!.userImagePath
                              .toString()
                              .isNotEmpty
                      ? Image.file(
                          File(SessionHelper.loginSavedData!.userImagePath.toString() ),
                fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                          fit: BoxFit.cover,
                        ),
            )),
      ),
    );
  }


  showAlertDialog({
    BuildContext? context,
    String? text,
  }) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel",
          style: TextStyle(color: primaryTextColor, fontSize: 16)),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(text!,
          style: const TextStyle(color: buttonFirstColor, fontSize: 16)),
      onPressed: () {
        if (text == 'Delete') {
          SessionManager.clearData();
          FirebaseAuth.instance.signOut();
          Get.offNamedUntil(
            ApplicationRoutes.loginScreen,
                (route) => false,
          );
        } else {
          SessionManager.clearData();
          FirebaseAuth.instance.signOut();
          Get.offNamedUntil(
            ApplicationRoutes.loginScreen,
                (route) => false,
          );
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColor,
      title: const Text(
        "Alert",
        style: TextStyle(fontSize: 20, color: buttonFirstColor),
      ),
      content: Text("Are you sure want to ${text.toLowerCase()} ?",
          style: TextStyle(fontSize: 16, color: primaryTextColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
