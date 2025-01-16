import 'package:actor/Controller/Authentication/signpcontroller.dart';
import 'package:actor/View/Authentication/login.dart';
import 'package:actor/View/Authentication/signupotppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  final Signpcontroller signpcontroller = Get.put(Signpcontroller());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
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
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: signpcontroller.nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person, color: Colors.purple),
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (Value) {
                          return signpcontroller.validateName(Value!);
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          controller: signpcontroller.emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email, color: Colors.purple),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return signpcontroller.validateEmail(value!);
                          }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return TextFormField(
                            obscureText:
                                signpcontroller.ispasswordVisible.value,
                            controller: signpcontroller.passwordController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.purple),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  signpcontroller.ispasswordVisible.value =
                                      !signpcontroller.ispasswordVisible.value;
                                },
                                icon: signpcontroller.ispasswordVisible.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return signpcontroller.validatePassword(value!);
                            });
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return TextFormField(
                            obscureText:
                                signpcontroller.iscpasswordVisible.value,
                            controller: signpcontroller.cpasswordController,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  signpcontroller.iscpasswordVisible.value =
                                      !signpcontroller.iscpasswordVisible.value;
                                },
                                icon: signpcontroller.iscpasswordVisible.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.purple),
                              hintText: "Confirm password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return signpcontroller
                                  .validateConfirmPassword(value);
                            });
                      }),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signpcontroller.Signupwithemail();
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Signup",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
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
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: const Text(
                          "Already have an account? Log in",
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
