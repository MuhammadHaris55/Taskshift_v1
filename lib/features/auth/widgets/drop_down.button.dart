import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

class CustomDropDownButton extends StatefulWidget {
  String role;
  CustomDropDownButton({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        //   height: 45.0,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.0.r),
        //     color: Colors.white,
        //     // border: Border.all(color: AppColors.colorGrey,width: 0.1),
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Color.fromRGBO(142, 142, 142, 0.5),
        //         blurRadius: 2,
        //         offset: Offset(0, 1),
        //       ),
        //     ],
        //   ),
        //   child:
        DropdownButtonFormField<String>(
      value: widget.role,
      // validator: (value) =>
      //     value == null || value == '' ? 'field required' : null,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      style: const TextStyle(
        fontFamily: appFontFamily,
        color: AppColors.colorBlack,
      ),
      // underline: Container(
      //   // height: 2,
      //   color: Colors.white,
      // ),
      focusColor: AppColors.colorBlue,
      isExpanded: true,
      onChanged: (String? value) {
        setState(() {
          widget.role = value!;
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
      // ),
    );
  }
}

// Container(
//       padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
//       height: 45.0,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.0.r),
//         color: Colors.white,
//         // border: Border.all(color: AppColors.colorGrey,width: 0.1),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(142, 142, 142, 0.5),
//             blurRadius: 2,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: DropdownButton<String>(
//         value: widget.role,
//         icon: const Icon(Icons.arrow_drop_down_outlined),
//         style: const TextStyle(
//           fontFamily: appFontFamily,
//           color: AppColors.colorBlack,
//         ),
//         underline: Container(
//           // height: 2,
//           color: Colors.white,
//         ),
//         focusColor: AppColors.colorBlue,
//         isExpanded: true,
//         onChanged: (String? value) {
//           setState(() {
//             widget.role = value!;
//           });
//         },
//         items: const [
//           DropdownMenuItem(
//             value: '',
//             child: Text(
//               "Your Role",
//               style: TextStyle(
//                 fontFamily: appFontFamily,
//                 color: AppColors.colorGrey,
//               ),
//             ),
//           ),
//           DropdownMenuItem(
//             value: "client",
//             child: Text("Client"),
//           ),
//           DropdownMenuItem(
//             value: "Freelancer",
//             child: Text("Freelancer"),
//           ),
//         ],
//         // dropDownOptions.map<DropdownMenuItem<String>>((String value) {
//         //   return DropdownMenuItem<String>(
//         //     value: value,
//         //     child: Text(
//         //       '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}',
//         //     ),
//         //   );
//         // }).toList(),
//       ),
//     );
