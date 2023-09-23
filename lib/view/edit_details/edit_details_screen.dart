import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/model/user_responce.dart';
import 'package:krushant_demo/theme/color/colors.dart';
import 'package:krushant_demo/utills/file_picking/custom_file_picker_option_widget.dart';
import 'package:krushant_demo/utills/session/sessionHelper.dart';
import 'package:krushant_demo/view/components/my_form_field.dart';
import 'package:krushant_demo/view/components/my_regular_text.dart';
import 'package:krushant_demo/view/components/my_theme_button.dart';
import 'package:krushant_demo/view/edit_details/edit_details_controller.dart';

class EditDetailScreen extends GetView<EditDetailsController> {
  const EditDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (controller.itemUpdated.isTrue) {
                  controller.showWaringDiloag();
                } else {
                  Get.back();
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          title: const MyRegularText(label: "Edit Profile", fontSize: 26, color: buttonFirstColor),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (controller.itemUpdated.isTrue) {
              controller.showWaringDiloag();
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: SafeArea(
            minimum: const EdgeInsets.all(16.0).copyWith(bottom: 0, top: 0),
            child: SingleChildScrollView(child: mainWidget(context)),
          ),
        ));
  }

  Widget mainWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height * 0.02,
          ),
          profileImageWidget(context),
          SizedBox(
            height: context.height * 0.02,
          ),
          MyFormField(
              controller: controller.userNameTextEditingController,
              isRequire: true,
              isShowDefaultValidator: true,
              onChanged: (value) {
                if (SessionHelper.loginSavedData!.userName !=
                    controller.userNameTextEditingController.text) {
                  controller.itemUpdated.value = true;
                }
              },
              labelText: "User Name"),
          SizedBox(
            height: context.height * 0.02,
          ),
          MyFormField(
              controller: controller.emailTextEditingController,
              isRequire: true,
              isShowDefaultValidator: true,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please Insert Email";
                } else if (GetUtils.isEmail(value) == false) {
                  return "Please Insert Valid Email";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                if (SessionHelper.loginSavedData!.email !=
                    controller.emailTextEditingController.text) {
                  controller.itemUpdated.value = true;
                }
              },
              labelText: "Email"),
          SizedBox(
            height: context.height * 0.02,
          ),
          MyFormField(
              controller: controller.workExpirienceTextEditingController,
              isRequire: true,
              isShowDefaultValidator: true,
              onChanged: (value) {
                if (SessionHelper.loginSavedData!.workExpirience !=
                    controller.workExpirienceTextEditingController.text) {
                  controller.itemUpdated.value = true;
                }
              },
              labelText: "Work Experience"),
          SizedBox(
            height: context.height * 0.02,
          ),
          const MyRegularText(
            label: "Skills",
            color: primaryTextColor,
          ),
          SizedBox(
            height: context.height * 0.01,
          ),
          Obx(() {
            return Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List<Widget>.generate(
                  controller.skills.length,
                  (index) => Card(
                        elevation: 3,
                        margin: index == 0 ? EdgeInsets.zero : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyRegularText(
                              label: controller.skills[index],
                              fontSize: 14,
                              color: primaryTextColor),
                        ),
                      ))
                ..add(Obx(
                  () => controller.isAddSkills.isFalse
                      ? Card(
                          elevation: 3,
                          child: IconButton(
                              padding: const EdgeInsets.all(4.0),
                              color: buttonSecondColor,
                              onPressed: () {
                                controller.isAddSkills.value =
                                    !controller.isAddSkills.value;
                                controller.updateWidget();
                              },
                              icon: const Icon(Icons.add)),
                        )
                      : const SizedBox(),
                )),
            );
          }),
          SizedBox(
            height: context.height * 0.01,
          ),
          Obx(
            () => controller.isAddSkills.isTrue
                ? MyFormField(
                    controller: controller.skillsTextEditingController,
                    labelText: "Skills",
                    suffixIcon: TextButton(
                      onPressed: () {
                        if (controller
                            .skillsTextEditingController.text.isNotEmpty) {
                          controller.addSkills(
                              controller.skillsTextEditingController.text);
                        } else {
                          controller.isAddSkills.value =
                              !controller.isAddSkills.value;
                          controller.updateWidget();
                        }
                      },
                      child: const MyRegularText(
                        label: 'Add',
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          SizedBox(
            height: context.height * 0.06,
          ),
          MyThemeButton(
              buttonText: "Update Details",
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.updateData(UserResponse(
                      userImagePath: controller.userImage.value,
                      userName: controller.userNameTextEditingController.text,
                      email: controller.emailTextEditingController.text,
                      workExpirience:
                          controller.workExpirienceTextEditingController.text,
                      skills: controller.skills,
                      password: SessionHelper.loginSavedData?.password ?? 'Krushant'));
                  Get.back();
                }
              })
        ],
      ),
    );
  }

  Widget profileImageWidget(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.height * 0.16,
        width: context.height * 0.17,
        child: InkWell(
          onTap: () {
            Get.defaultDialog<File>(
                    title: "Choose Image",
                    content: const Flexible(child: CustomFilePickerOptionWidget()))
                .then((value) {
              if (value != null) {
                controller.itemUpdated.value = true;
                controller.userImage.value = value.path;
                controller.updateWidget();
              }
            });
          },
          child: Stack(
            children: [
              Hero(
                tag: "ImgKrushant",
                child: SizedBox(
                    // color: Colors.yellow,
                    height: context.height * 0.16,
                    width: context.height * 0.16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.height * 0.16,
                      ),
                      child: Obx(
                        () => GetUtils.isURL(controller.userImage.value)
                            ? Image.network(
                                controller.userImage.value,
                                fit: BoxFit.cover,
                              )
                            : controller.userImage.isNotEmpty
                                ? Image.file(
                                    File(controller.userImage.value.toString()),
                          fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    )),
              ),
              const Positioned(
                right: 8,
                bottom: 10,
                child: Icon(Icons.edit, size: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
