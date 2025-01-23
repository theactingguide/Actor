import 'package:actor/Controller/Authentication/logincontroller.dart';
import 'package:actor/View/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Emailscreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          TextFormField(
                            controller: loginController.emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.purple),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return loginController.validateEmail();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                if (loginController
                                    .emailController.text.isNotEmpty) {
                                  loginController.resetpassword();
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Send ",
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
          Obx(() {
            if (loginController.isloading.value) {
              return Container(
                color: const Color.fromARGB(255, 82, 76, 76), // Dim background
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
