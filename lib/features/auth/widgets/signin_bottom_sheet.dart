import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/common/widgets/bottom_bar.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/features/auth/services/auth_services.dart';
import 'package:taskshift_v1/features/auth/widgets/social_media_login.dart';

import '../../../common/widgets/custom_text_form_field.dart';
import '../../../constants/global_variables.dart';
import 'signup_bottom_sheet.dart';

signInBottomModal(
  BuildContext context,
  TextEditingController firstNameController,
  TextEditingController lastNameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
  String role,
) {
  final AuthService authService = AuthService();
  final signInFormKey = GlobalKey<FormState>();

  return showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(38.0.r),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          // height: 493.0.h,
          padding: EdgeInsets.only(top: 39.0.h, right: 19.0.w, left: 19.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(38.0.r),
              topLeft: Radius.circular(38.0.r),
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TitleText(text: 'Welcome Back'),
                ),
                SizedBox(height: 27.0.h),
                Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        textEditingController: emailController,
                        hintText: 'Email',
                        icon: const Icon(Icons.mail),
                      ),
                      SizedBox(height: 23.0.h),
                      CustomTextFormField(
                        textEditingController: passwordController,
                        hintText: 'Password',
                        icon: const Icon(Icons.lock),
                        obscure: true,
                      ),
                      SizedBox(height: 42.0.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.colorBlue,
                              fontSize: 27.0.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: appFontFamily,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                              if (signInFormKey.currentState!.validate()) {
                                print('signIn');
                                authService.userLogin(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.white,
                              size: 25.0.h,
                            ),
                          ),
                          // FloatingActionButton(
                          //   // onPressed: () => Navigator.pushNamed(
                          //   //     context, BottomBar.routeName),
                          //   onPressed: () {
                          //     print('Sign in');
                          //     // if (signInFormKey.currentState!.validate()) {
                          //     //   authService.userLogin(
                          //     //     context: context,
                          //     //     email: emailController.text.trim(),
                          //     //     password: passwordController.text.trim(),
                          //     //   );
                          //     // }
                          //   },
                          //   backgroundColor: AppColors.colorBlue,
                          //   child: Icon(
                          //     Icons.arrow_forward_sharp,
                          //     color: Colors.white,
                          //     size: 25.0.h,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 40.0.h),
                    ],
                  ),
                ),
                const SocialMediaLoginRow(),
                SizedBox(height: 39.0.h),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: AppColors.colorGrey,
                      fontSize: 16.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            signUpBottomModal(
                              context,
                              firstNameController,
                              lastNameController,
                              emailController,
                              passwordController,
                              confirmPasswordController,
                              role,
                            );
                          },
                        text: 'Sign Up',
                        style: TextStyle(
                          color: AppColors.colorBlue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
