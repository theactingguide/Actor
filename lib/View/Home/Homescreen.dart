import 'package:actor/Controller/Authentication/logincontroller.dart';
import 'package:actor/View/Authentication/login.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            loginController.signOut();

            Get.to(() => LoginScreen());
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
