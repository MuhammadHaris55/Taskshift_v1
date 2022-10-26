import 'package:flutter/material.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/constants/global_variables.dart';

import 'widgets/signin_bottom_sheet.dart';

enum SingingCharacter { lafayette, jefferson }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? role;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Image(
          image: AssetImage(AssetImages.appLogo),
        ),
        actions: [
          TextButton(
            onPressed: () =>
              signInBottomModal(
                context,
                firstNameController,
                lastNameController,
                emailController,
                passwordController,
                confirmPasswordController,
              ),
            
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SubtitleText(text: 'Sign In', color: AppColors.colorBlue,),
              // Text(
              //   'Sign In',
              //   style: TextStyle(
              //     fontFamily: appFontFamily,
              //     // fontFamily: 'Nunito',
              //     color: AppColors.colorBlue,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //   ),
              // ),
            ),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(
            width: double.infinity, height: double.infinity),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(
              AssetImages.backscreen,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}
