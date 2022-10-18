import 'package:flutter/cupertino.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

// ignore: must_be_immutable
class CustomNormalText extends StatelessWidget {
  String text;
  CustomNormalText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize:13,
          fontWeight: FontWeight.w400,
          color: AppColors.colorGrey,
          fontFamily: 'Nunito-Regular'),
    );
  }
}

// ignore: must_be_immutable
class CustomHeading extends StatelessWidget {
  String text;
  CustomHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize:25,
          fontWeight: FontWeight.w700,
          color: AppColors.colorBlue,
          fontFamily: 'Nunito-Bold'),
    );
  }
}

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;

  CustomText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ////// frontfamilycall////////////////////
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
           fontSize:13,
          fontWeight: FontWeight.w400,
          color: AppColors.colorBlue,
          fontFamily: 'Nunito-Regular'),
    );
  }
}
