import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/login/remote_login_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/validate_username_request.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';

class OnClocLoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var f1 = FocusNode();
  var f2 = FocusNode();

  var isValidDevice = false.obs;
  var isDeviceVerified = false.obs;
  var isLoading = false.obs;
  var isLoginWithUidBtnLoading = false.obs;
  var isPasswordEnabled = false.obs;
  var isEmailEnabled = false.obs;
  var isIconTrue = true.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    isEmailEnabled.value = true;
    isPasswordEnabled.value = true;
    super.onInit();
  }

  Future<void> validateRemoteLogin() async {
    var userName = emailController.text;
    var secretPass = passwordController.text;
    if (userName.isEmptyOrNull || secretPass.isEmptyOrNull) {
      isEmailEnabled.value = false;
      isPasswordEnabled.value = false;
    } else {
      var emailIsValid = await validateUsername(userName);
      if (emailIsValid) {
        var loginResponse = await remoteLogin();
        if (getBoolAsync(isLoggedInPref)) {
          isEmailEnabled.value = true;
          isPasswordEnabled.value = true;
          onClocSharedHelper.refreshAppSettings();
          if (getBoolAsync(requires2faPref)) {
            Get.offNamed(OnClocRoutes.onClocTwoFactorAuthenticationScreen);
          } else {
            Get.offNamed(OnClocRoutes.onClocNavigationScreen);
          }
        }
        toast(loginResponse.toString());
      } else {
        isEmailEnabled.value = false;
        isPasswordEnabled.value = false;
        toast(onClocLocale.lblUsernamePasswordInvalid);
      }
    }
  }

  Future<String> remoteLogin() async {
    isLoading.value = true;
    var loginRequest = RemoteLoginRequest(
      username: emailController.text,
      password: passwordController.text,
    );
    var userProfile = await onClocApiService.remoteLogin(loginRequest);
    if (userProfile == null) {
      await setValue(isLoggedInPref, false);
      await setValue(isDeviceVerifiedPref, false);
      isLoading.value = false;
      return onClocLocale.lblPleaseEnterValidCredentials;
    } else {
      // Set Shared Preferences
      bool isUserEnabled = userProfile.status == SysAccess.granted.name;
      if (isUserEnabled) {
        await setValue(isLoggedInPref, isUserEnabled);
        await setValue(isDeviceVerifiedPref, false);
        await setValue(userIdPref, userProfile.userId);
        await setValue(serviceOfficeProfileIdPref, userProfile.serviceOfficerProfileId);
        await setValue(firstNamePref, userProfile.firstName);
        await setValue(lastNamePref, userProfile.lastName);
        await setValue(emailPref, userProfile.email);
        await setValue(avatarPref, userProfile.avatarUrl);
        await setValue(addressPref, userProfile.address);
        await setValue(phoneNumberPref, userProfile.phoneNumber);
        await setValue(alternateNumberPref, userProfile.alternateNumber);
        await setValue(statusPref, userProfile.status);
        await setValue(tokenPref, userProfile.token);
        await setValue(tenantPref, userProfile.tenantId);
        await setValue(requires2faPref, userProfile.requiresTfa);
      } else {
        return onClocLocale.lblUserLockedOut;
      }
      isLoading.value = false;
      return onClocLocale.lblLoginSuccessful;
    }
  }

  Future<bool> validateUsername(String username) async {
    var payload = ValidateUsernameRequest(username: username);
    // Check if the email is already registered
    bool validated = await onClocApiService.validateUsername(payload);
    isEmailEnabled.value = validated;
    return validated;
  }

  String validateEmailText(String? emailText) {
    if (emailText == null || emailText.isEmpty) {
      isEmailEnabled.value = false;
      return onClocLocale.lblPleaseEnterEmail;
    }
    // Email Validation
    final isValid = EmailValidator.validate(emailText);
    if (!isValid) {
      isEmailEnabled.value = false;
      return onClocLocale.lblPleaseEnterValidCredentials;
    }
    isEmailEnabled.value = true;
    return '';
  }

  String validatePasswordText(String? secretText) {
    if (secretText == null || secretText.isEmpty) {
      isPasswordEnabled.value = false;
      return onClocLocale.lblPleaseEnterPassword;
    }

    if (secretText.length < 8) {
      isPasswordEnabled.value = false;
      return onClocLocale.lblPleaseEnterValidPassword;
    }

    isPasswordEnabled.value = true;
    return '';
  }

  void goToEnrol() {
    Get.toNamed(OnClocRoutes.onClocEnrolScreen);
  }
}

enum SysAccess{
  granted,
  locked,
  invalid
}