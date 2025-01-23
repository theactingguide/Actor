import 'dart:ui_web';

import 'package:actor/Controller/Authentication/logincontroller.dart';
import 'package:actor/Controller/Home/Homecontroller.dart';
import 'package:actor/View/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usernamescreen extends StatelessWidget {
  final Homecontroller homeController = Get.put(Homecontroller());
  final _formkey = GlobalKey<FormState>();
  String url =
      "https://firebasestorage.googleapis.com/v0/b/the-acting-guide.firebasestorage.app/o/actor%2Fimages%2FPant%20(2).webp?alt=media&token=b90a3f8a-6870-478f-a767-62412a8dbe9a";

  @override
  Widget build(BuildContext context) {
    String encodedUrl =
        Uri.encodeFull(url); // Ensures URL is correctly encoded.
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              // The image inside a circle
                              ClipOval(
                                child: Obx(() {
                                  return homeController.imageurl.value == ""
                                      ? Image.asset(
                                          "images/google.png",
                                          fit: BoxFit.fill,
                                          width: 200,
                                          height: 200,
                                        )
                                      : Image.network(
                                          homeController.imageurl.value,
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 200,
                                        );
                                }),
                              ),

                              // Icon outside the circular image
                              Positioned(
                                right: 20, // Adjusted positioning
                                bottom: 0, // Set to 0 to ensure visibility
                                child: IconButton(
                                  onPressed: () async {
                                    await homeController.pickImage();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                  ),
                                  iconSize: 40, // Increased icon size
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: homeController.usernamecontroller,
                              decoration: InputDecoration(
                                labelText: "Username",
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.purple),
                                hintText: "Username",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (Value) {
                                return homeController.validateusername();
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                // Only submit if the form is valid
                                homeController.submitusername();
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Submit ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Obx(() {
          //   if (loginController.isloading.value) {
          //     return Container(
          //       color: const Color.fromARGB(255, 82, 76, 76), // Dim background
          //       child: Center(
          //         child: CircularProgressIndicator(
          //           valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          //         ),
          //       ),
          //     );
          //   } else {
          //     return SizedBox.shrink();
          //   }
          // }),
        ],
      ),
    );
  }
}
