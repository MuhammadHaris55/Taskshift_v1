import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 69.h,
      color: Colors.white,
      child: AppBar(
        //toolbarHeight: 70,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        elevation: 2,
        backgroundColor: AppColors.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Image.asset(
            AssetImages.appLogo,
            fit: BoxFit.contain,
            height: 32,
          ),
        ),
      ),
    );
  }
}
