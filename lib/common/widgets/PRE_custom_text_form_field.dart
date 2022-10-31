import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/global_variables.dart';

class PRE_CustomTextFormField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  Icon icon;
  bool? obscure;
  PRE_CustomTextFormField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40.h,
      constraints: BoxConstraints(
        minHeight: 40.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.r),
        color: Colors.white,
        // border: Border.all(color: AppColors.colorGrey,width: 0.1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(142, 142, 142, 0.5),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscure ?? false,
        textCapitalization: TextCapitalization.sentences,
        // onChanged: (value) {
        //   textEditingController.text = value;
        // },
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
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderSide: const BorderSide(
              color: AppColors.colorGrey,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.colorBlue,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          hintStyle: const TextStyle(
            color: AppColors.colorGrey,
            fontFamily: appFontFamily,
          ),
          hintText: hintText,
          suffixIcon: icon,
        ),
      ),
    );
  }
}
