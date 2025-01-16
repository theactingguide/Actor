import 'dart:async';

import 'package:actor/Controller/Authentication/logincontroller.dart';
import 'package:actor/View/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Loginotppage extends StatefulWidget {
  const Loginotppage({super.key});

  @override
  State<Loginotppage> createState() => _LoginotppageState();
}

class _LoginotppageState extends State<Loginotppage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  RxBool isButtonDisabled = false.obs;
  Timer? _timer;
  int _start = 180;

  void startTimer() {
    isButtonDisabled.value = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        _start--;
      } else {
        _timer?.cancel();
        isButtonDisabled.value = false;
        _start = 180;

        loginController.otp.value = "";
      }
    });
  }

  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  final TextEditingController otp5 = TextEditingController();
  final TextEditingController otp6 = TextEditingController();

  final LoginController loginController = Get.put(LoginController());

  void mergeotp() {
    loginController.otp.value =
        otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.off(() => LoginScreen());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Otp Verification",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "We have sent the verification code to your mobile number",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Customotpfield(
                        controller: otp1,
                        voidCallback: mergeotp,
                      ),
                      Customotpfield(
                        controller: otp2,
                        voidCallback: mergeotp,
                      ),
                      Customotpfield(
                        controller: otp3,
                        voidCallback: mergeotp,
                      ),
                      Customotpfield(
                        controller: otp4,
                        voidCallback: mergeotp,
                      ),
                      Customotpfield(
                        controller: otp5,
                        voidCallback: mergeotp,
                      ),
                      Customotpfield(
                        controller: otp6,
                        voidCallback: mergeotp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: InkWell(onTap: () async {
                      print("object");
                      if (loginController.otp.value.length == 6) {
                        print("the otp is ${loginController.otp}");

                        otp1.clear();
                        otp2.clear();
                        otp3.clear();
                        otp4.clear();
                        otp5.clear();
                        otp6.clear();
                      } else {
                        null;
                      }
                    }, child: Obx(() {
                      return Container(
                        height: 60,
                        color: loginController.otp.value.length == 6
                            ? Colors.blue
                            : const Color.fromARGB(255, 143, 183, 215),
                        alignment: Alignment.center,
                        child: Text(
                          "Verify Otp",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    })),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       _isButtonDisabled
                  //           ? 'Resend code in $_start seconds'
                  //           : "Didn't receive the code?",
                  //       style: TextStyle(fontSize: 17),
                  //     ),
                  //     SizedBox(width: 20),
                  //     !_isButtonDisabled
                  //         ? InkWell(
                  //             onTap: () {
                  //               startTimer();
                  //               signpcontroller.resendcode();
                  //             },
                  //             child: Text(
                  //               'Resend Code',
                  //               style: TextStyle(fontSize: 17),
                  //             ),
                  //           )
                  //         : SizedBox(),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Customotpfield extends StatelessWidget {
  Customotpfield({
    super.key,
    required this.controller,
    required this.voidCallback,
  });
  final TextEditingController controller;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 60,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          voidCallback();
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 69, 67, 67))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}
