import 'package:actor/View/Home/Homescreen.dart';
import 'package:actor/View/Home/usernamescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signpcontroller extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  RxString verificationid = "".obs;

  RxBool ispasswordVisible = true.obs;
  RxBool iscpasswordVisible = true.obs;
  RxBool mobileverified = false.obs;
  RxString otp = "".obs;
  UserCredential? userCredential;

  Signupwithemail() async {
    try {
      UserCredential mainuserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      if (mainuserCredential.user != null) {
        await mainuserCredential.user!
            .updateDisplayName(nameController.text.trim());
        print(mainuserCredential);

        Get.snackbar("Success", "Signup completed successfully!");

        User? user = FirebaseAuth.instance.currentUser;
        print(user);
        Get.to(() => Usernamescreen());
      }
    } on FirebaseAuthException catch (e) {
      print("Error:${e.code}");
      print("Error:${e.message}");
      String errorMessage = "An unknown error occurred";
      if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      } else if (e.code == 'user-disabled') {
        errorMessage = "This user has been disabled";
      } else if (e.code == 'invalid-credential') {
        errorMessage = "The supplied auth credential is incorrect";
      } else if (e.code == "email-already-in-use") {
        errorMessage = "The email already exist";
      }
      Get.showSnackbar(GetSnackBar(
        message: errorMessage,
        duration: const Duration(seconds: 2),
      ));
    } catch (e) {
      print("Error updating user details: $e");
      Get.snackbar("Error", "Failed to complete signup. Try again.");
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name is required";
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
