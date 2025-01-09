import 'package:actor/Controller/Authentication/logincontroller.dart';
import 'package:actor/View/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
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
                            const Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 20),
                            Obx(
                              () {
                                return TextFormField(
                                    controller:
                                        loginController.passwordController,
                                    obscureText:
                                        loginController.isPasswordVisible.value,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,
                                          color: Colors.purple),
                                      labelText: "Password",
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            loginController
                                                    .isPasswordVisible.value =
                                                !loginController
                                                    .isPasswordVisible.value;
                                          },
                                          icon: loginController
                                                  .isPasswordVisible.value
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility)),
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      return loginController.validatePassword();
                                    });
                              },
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.purple),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "OR",
                              style:
                                  TextStyle(color: Colors.purple, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller:
                                    loginController.mobileNumberController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.phone, color: Colors.purple),
                                  labelText: "Mobile Number",
                                  hintText: "Mobile Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  return loginController.validateMobileNumber();
                                }),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {}
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Get.to(() => SignupScreen());
                              },
                              child: const Text(
                                "Don't have an account? Sign Up",
                                style: TextStyle(color: Colors.purple),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}