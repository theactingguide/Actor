import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  RxBool isPasswordVisible = true.obs;

  String? validateEmail() {
    String value = emailController.text.trim();
    if (value.isNotEmpty) {
      if (!GetUtils.isEmail(value)) {
        return "Enter a valid email";
      }
      return null;
    }
    return null;
  }

  String? validatePassword() {
    String value = passwordController.text.trim();
    if (value.isNotEmpty) {
      if (value.length < 6) {
        return "Password must be at least 6 characters";
      }
      return null;
    }
    return null;
  }

  String? validateMobileNumber() {
    String value = mobileNumberController.text.trim();
    if (value.isNotEmpty) {
      if (!GetUtils.isPhoneNumber(value)) {
        return "Enter a valid phone number";
      }
      return null;
    }
    return null;
  }
}
