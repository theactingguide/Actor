import 'package:actor/View/Authentication/login.dart';
import 'package:actor/View/Home/Homescreen.dart';
import 'package:actor/View/Home/usernamescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  late GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
        clientId:
            "468470770669-e9akhprmiu579mkrd59300desl76tc2c.apps.googleusercontent.com");
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxString verificationid = "".obs;
  RxBool isloading = false.obs;
  // var _googleSignIn = GoogleSignIn(
  //     scopes: [
  //       'email',
  //       'profile',
  //     ],
  //     clientId:
  //         "468470770669-e9akhprmiu579mkrd59300desl76tc2c.apps.googleusercontent.com");
  RxString otp = "".obs;

  signInWithGoogle() async {
    isloading(true);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isloading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print(googleAuth.accessToken);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
      );
      print(credential);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential);
      // if (userCredential.user) {
      //   Get.to(() {
      //     Homescreen();
      //   });
      // }
      print(userCredential.additionalUserInfo!.isNewUser);
      if (userCredential.additionalUserInfo!.isNewUser) {
        print("new");
        Get.to(() => Usernamescreen());
      } else {
        print("old");
        Get.to(() => Homescreen());
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'account-exists-with-different-credential') {
        Get.snackbar(
          "Error",
          "An account already exists with this email. Please try another method.",
        );
      } else {
        Get.snackbar(
          "Error",
          e.message ?? "Failed to sign in with Google.",
        );
      }
    } catch (e) {
      print("Google Sign-In Error: ${e.toString()}");
      // Get.snackbar("Error", e.toString());
    } finally {
      isloading(false); // Hide loading indicator when done
    }
  }

  void login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.showSnackbar(GetSnackBar(
        message: "Please fill all the fields",
        duration: const Duration(seconds: 2),
      ));
    } else {
      isloading(true);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("User: ${userCredential.user}");
        emailController.text = "";
        passwordController.text = "";
        Get.to(() => Homescreen());
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
        print("Error: $e");
        Get.showSnackbar(GetSnackBar(
          message: "An unexpected error occurred. Please try again.",
          duration: const Duration(seconds: 2),
        ));
      } finally {
        isloading(false);
      }
    }
  }

  void resetpassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.showSnackbar(GetSnackBar(
        message: "Please enter your email address",
        duration: const Duration(seconds: 2),
      ));
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.showSnackbar(GetSnackBar(
        message: "Password reset link has been sent to your email",
        duration: const Duration(seconds: 2),
      ));
      Get.to(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email address";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is invalid";
      }
      Get.showSnackbar(GetSnackBar(
        message: errorMessage,
        duration: const Duration(seconds: 2),
      ));
    } catch (e) {
      print("Error: $e");
      Get.showSnackbar(GetSnackBar(
        message: "An unexpected error occurred. Please try again later.",
        duration: const Duration(seconds: 2),
      ));
    }
  }

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

  void signOut() async {
    try {
      print("1");

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      } else {
        print("2");
        await FirebaseAuth.instance.signOut();
      }

      print("User signed out successfully");
    } catch (e) {
      print("Sign Out Error: $e");
      Get.snackbar("Error", "Failed to sign out. Please try again.");
    }
  }
}
