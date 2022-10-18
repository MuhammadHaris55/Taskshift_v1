import 'package:flutter/material.dart';

class AssetImages {
  static String googleImage = 'assets/images/googleImge.png';
  static String appleImage = 'assets/images/apple.png';
  static String facebookImage = 'assets/images/facebook.png';
  static String appLogo = 'assets/images/Taskshift_logo.png';
  static String backscreen = 'assets/images/backscreen.png';
}

class AppColors {
  static const backgroundColor = Colors.white;
  static const Color colorGrey = Color.fromRGBO(142, 142, 142, 1);
  static const Color colorBlue = Color.fromRGBO(47, 85, 212, 1);
  static const Color colorBlack = Colors.black;
  // static const Color greyAppBarBackgroundColor =
  //     Color.fromARGB(255, 241, 241, 244);
}

////////////////////////CustomClassForInkWell///////////////////////////////
class customInkWell extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var image;

  customInkWell({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(
        image,
        width: 50,
        height: 50,
      ),
      onTap: () {},
    );
  }
}
