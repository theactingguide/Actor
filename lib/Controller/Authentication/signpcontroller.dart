import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signpcontroller extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  RxBool ispasswordVisible = true.obs;
  RxBool iscpasswordVisible = true.obs;

  Signupwithemail() {}

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Phone is required";
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    }
    if (!GetUtils.isEmail(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm password is required";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
