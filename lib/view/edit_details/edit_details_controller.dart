import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/model/user_responce.dart';
import 'package:krushant_demo/theme/color/colors.dart';
import 'package:krushant_demo/utills/session/sessionhelper.dart';
import 'package:krushant_demo/view/components/my_regular_text.dart';

class EditDetailsController extends GetxController {
  TextEditingController userNameTextEditingController = TextEditingController(),
      emailTextEditingController = TextEditingController(),
      workExpirienceTextEditingController = TextEditingController(),
      skillsTextEditingController = TextEditingController();
  RxList<String> skills = <String>[].obs;
  RxString userImage = "".obs;
  RxBool isAddSkills = false.obs;
  RxBool itemUpdated = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  onInit() {
    super.onInit();
    loadDataToLocal();
  }

  updateWidget() {
    refresh();
  }

  addSkills(String newSkill) {
    isAddSkills.value = !isAddSkills.value;
    skills.add(newSkill);
    itemUpdated.value = true;
    skillsTextEditingController.clear();
    refresh();
  }

  updateData(UserResponse userResponse) async {
    await SessionHelper().getLoginData().then((value) async {
      if (value != null) {
        SessionHelper.loginSavedData =
            await SessionHelper().setLoginData(userResponse);
      } else {
        SessionHelper.loginSavedData = userResponse;
      }

      itemUpdated.value = false;
      Get.snackbar("Success", "Details Updated",colorText: green);
      refresh();
    });
  }

  loadDataToLocal() {
    SessionHelper().getLoginData().then((value) {
      if (value != null) {
        userNameTextEditingController.text =
            value.userName ?? userNameTextEditingController.text;
        emailTextEditingController.text =
            value.email ?? emailTextEditingController.text;
        workExpirienceTextEditingController.text =
            value.workExpirience ?? workExpirienceTextEditingController.text;
        userImage.value = value.userImagePath ?? userImage.value;
        skills.value = value.skills ?? [];
        refresh();
      } else {
        userNameTextEditingController.text =
            SessionHelper.loginSavedData?.userName ??
                userNameTextEditingController.text;
        emailTextEditingController.text = SessionHelper.loginSavedData?.email ??
            emailTextEditingController.text;
        workExpirienceTextEditingController.text =
            SessionHelper.loginSavedData?.workExpirience ??
                workExpirienceTextEditingController.text;
        userImage.value =
            SessionHelper.loginSavedData?.userImagePath ?? userImage.value;
        skills.value = SessionHelper.loginSavedData?.skills ?? [];
        refresh();
      }
    });
  }

    showWaringDiloag() {
    Get.defaultDialog(
      title: "Leave without saving?",
      titleStyle:   const TextStyle(
        color: buttonFirstColor,
        fontSize: 16
      ),
      cancel: TextButton(onPressed: () {
        Get.back();
      }, child: const Text("Cancel")),
      middleText: "",
      confirm: TextButton(
          onPressed: () {
            Get.back(result: ["ABABBA"]);
            Get.back(result: ["ABABBA"]);
          },
          child: const MyRegularText(
            label: "Leave",
            color: errorColor,
          )),
    );
  }
}
