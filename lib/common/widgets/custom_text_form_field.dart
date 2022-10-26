import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/global_variables.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  Icon icon;
  CustomTextFormField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
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
        textCapitalization: TextCapitalization.sentences,
        // onChanged: (value) {
        //   textEditingController.text = value;
        // },
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
