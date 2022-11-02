import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/common/widgets/bottom_bar.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/constants/utils.dart';
import 'package:taskshift_v1/features/auth/services/auth_services.dart';
import '../../../common/widgets/custom_text_form_field.dart';
import 'drop_down.button.dart';
import 'signin_bottom_sheet.dart';
import 'social_media_login.dart';

signUpBottomModal(
  BuildContext context,
  TextEditingController firstNameController,
  TextEditingController lastNameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
  String role,
) {
  AuthService authService = AuthService();
  final signUpFormKey = GlobalKey<FormState>();

  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(38.0.r),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Container(
              // height: 493.0.h,
              padding:
                  EdgeInsets.only(top: 37.0.h, right: 19.0.w, left: 19.0.w),
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
                      child: TitleText(text: 'Register Your Account'),
                    ),
                    SizedBox(height: 27.0.h),
                    Form(
                      key: signUpFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            textEditingController: firstNameController,
                            hintText: 'First Name',
                            icon: const Icon(Icons.person),
                          ),
                          SizedBox(height: 21.0.h),
                          CustomTextFormField(
                            textEditingController: lastNameController,
                            hintText: 'Last Name',
                            icon: const Icon(Icons.person),
                          ),
                          SizedBox(height: 21.0.h),
                          CustomTextFormField(
                            textEditingController: emailController,
                            hintText: 'Email',
                            icon: const Icon(Icons.mail),
                          ),
                          SizedBox(height: 21.0.h),
                          CustomTextFormField(
                            textEditingController: passwordController,
                            hintText: 'Password',
                            icon: const Icon(Icons.lock),
                            obscure: true,
                          ),
                          SizedBox(height: 21.0.h),
                          CustomTextFormField(
                            textEditingController: confirmPasswordController,
                            hintText: 'Confirm Password',
                            icon: const Icon(Icons.lock),
                            obscure: true,
                          ),
                          SizedBox(height: 21.0.h),

                          ///---------------------------------------------------
                          // CustomDropDownButton(role: role),
                          // DropdownButtonFormField<String>(
                          //     itemHeight: 45.0,
                          //     value: role,
                          //     onChanged: (value) =>
                          //         setState(() => role = value!),
                          //     validator: (value) =>
                          //         value == '' ? 'Role field is required' : null,
                          //     items: const [
                          //       DropdownMenuItem<String>(
                          //         value: '',
                          //         child: Text('Role'),
                          //       ),
                          //       DropdownMenuItem<String>(
                          //         value: 'client',
                          //         child: Text('Client'),
                          //       ),
                          //       DropdownMenuItem<String>(
                          //         value: 'freelancer',
                          //         child: Text('Freelancer'),
                          //       )
                          //     ]
                          //     // ['client', 'freelancer']
                          //     //     .map<DropdownMenuItem<String>>((String value) {
                          //     //   return DropdownMenuItem<String>(
                          //     //     value: value,
                          //     //     child: Text(value),
                          //     //   );
                          //     // }).toList(),
                          //     ),
                          DropdownButtonFormField<String>(
                            value: role,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            style: const TextStyle(
                              fontFamily: appFontFamily,
                              color: AppColors.colorBlack,
                            ),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12.0)),
                            // underline: Container(
                            //   // height: 2,
                            //   color: Colors.white,
                            // ),
                            focusColor: AppColors.colorBlue,
                            isExpanded: true,
                            onChanged: (String? value) {
                              setState(() {
                                role = value!;
                              });
                            },
                            validator: (value) =>
                                value == '' ? 'Role field is required' : null,
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

                          ///---------------------------------------------------
                          SizedBox(height: 42.0.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sign Up',
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
                                  showSnackBar(context, 'text');
                                  // if (signUpFormKey.currentState!.validate()) {
                                  //   authService.userSignUp(
                                  //     context: context,
                                  //     name: firstNameController.text.trim(),
                                  //     lastName: lastNameController.text.trim(),
                                  //     email: emailController.text.trim(),
                                  //     password: passwordController.text.trim(),
                                  //     passwordConfirmation:
                                  //         confirmPasswordController.text.trim(),
                                  //     role: role,
                                  //   );
                                  // }
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
                              //   onPressed: () => Navigator.pushNamed(
                              //       context, BottomBar.routeName),
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
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.colorGrey,
                          fontSize: 16.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                signInBottomModal(
                                  context,
                                  firstNameController,
                                  lastNameController,
                                  emailController,
                                  passwordController,
                                  confirmPasswordController,
                                  role,
                                );
                              },
                            text: 'Sign In',
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
    },
  );
}
