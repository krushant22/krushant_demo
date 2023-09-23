import 'dart:convert';
import 'dart:developer';

import 'package:krushant_demo/model/user_responce.dart';
import 'package:krushant_demo/utills/session/sp_string.dart';

import 'null_check_oprations.dart';
import 'sessionmanager.dart';

class SessionHelper {
  SessionHelper._();

  static final SessionHelper _instance = SessionHelper._();

  factory SessionHelper() {
    return _instance;
  }

  Future<UserResponse> setLoginData(UserResponse loginResponce) async {
    // save Login Data in shared pref
    await SessionManager.setStringValue(
        SpString.spLoginKey, jsonEncode(loginResponce.toJson()));

    return loginResponce;
  }

  static UserResponse? loginSavedData;

  Future<UserResponse?> getLoginData() async {
    // get Login Data from shared pref
    String response = await SessionManager.getStringValue(SpString.spLoginKey);
    if (CheckNullData.checkNullOrEmptyString(response)) {
      return null;
    } else {
      log(response);
      return UserResponse.fromJson(jsonDecode(response));
    }
  }

  Future<int> setAttemptIntroData(int attempt) async {
    // save Intro Data in shared pref
    await SessionManager.setIntValue(SpString.spIntroKey, attempt);
    return await getAttemptIntroData();
  }

  Future<int> getAttemptIntroData() async {
    // get Intro Data from shared pref
    return await SessionManager.getIntValue(SpString.spIntroKey);
  }
}
