import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Customotpfield1 extends StatelessWidget {
  Customotpfield1({
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
