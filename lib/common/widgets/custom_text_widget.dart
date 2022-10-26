import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskshift_v1/constants/global_variables.dart';

class TitleText extends StatelessWidget {
  String text;
  TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.colorBlue,
      ),
    );
  }
}


class SubtitleText extends StatelessWidget {
  String text;
  Color? color;
  SubtitleText({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.black,
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  String text;
  BodyText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  String text;
  DetailText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}




