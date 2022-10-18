import 'package:flutter/material.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

class costomTextField extends StatefulWidget {
  TextEditingController textEditingController;
  String hintText;
  Icon icon;
  costomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  State<costomTextField> createState() => _costomTextFieldState();
}

class _costomTextFieldState extends State<costomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      onChanged: (value) {
        widget.textEditingController.text = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.colorBlue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.colorGrey,
        ),
        hintText: widget.hintText,
        suffixIcon: widget.icon,
      ),
    );
  }
}
