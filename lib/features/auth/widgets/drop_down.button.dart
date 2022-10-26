import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  
  String? dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      height: 40.h,
      width: double.infinity,
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
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_outlined),
        style: const TextStyle(
          fontFamily: appFontFamily,
          color: AppColors.colorBlack,
        ),
        underline: Container(
          // height: 2,
          color: Colors.white,
        ),
        focusColor: AppColors.colorBlue,
        isExpanded: true,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: '',
            child: Text(
              "Your Role",
              style: TextStyle(
                fontFamily: appFontFamily,
                color: AppColors.colorGrey,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "client",
            child: Text("Client"),
          ),
          DropdownMenuItem(
            value: "Freelancer",
            child: Text("Freelancer"),
          ),
        ],
        // dropDownOptions.map<DropdownMenuItem<String>>((String value) {
        //   return DropdownMenuItem<String>(
        //     value: value,
        //     child: Text(
        //       '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}',
        //     ),
        //   );
        // }).toList(),
      ),
    );
  }
}
