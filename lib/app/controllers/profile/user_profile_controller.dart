import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocUserProfileController extends GetxController {
  TextEditingController avatorController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController reportingManagerController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyContactController = TextEditingController();
  TextEditingController companyOfficeTimeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    avatorController.text = getStringAsync(avatarPref);
    fullNameController.text = '${getStringAsync(firstNamePref)} ${getStringAsync(lastNamePref)}';
    emailController.text = getStringAsync(emailPref);
    contactNumberController.text = getStringAsync(phoneNumberPref);
    designationController.text = getStringAsync(addressPref);
    employeeIdController.text = '7879987';
    departmentController.text = 'Service & Parts';
    reportingManagerController.text = 'Ian Walker';
    companyEmailController.text = 'service@engsol.co.ug';
    companyContactController.text = '(+256) 772 550999';
    companyOfficeTimeController.text = '10:00 am to 07:00 pm';
  }
}
