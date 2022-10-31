import 'package:flutter/material.dart';

// We define a class and called it at the root in MaterialApp widget in themeData function

class CustomTextFormField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  Icon icon;
  bool? obscure;
  CustomTextFormField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure ?? false,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        if (hintText == 'Email') {
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(val)) {
            return 'Enter a valid email';
          }
        }
        return null;
      },
      // ),
    );
  }
}
