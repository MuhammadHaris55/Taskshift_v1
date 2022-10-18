import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/common/widgets/custom_text.dart';
import 'package:taskshift_v1/common/widgets/custom_textfield.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/features/login_signUp/widgets/backScreen_body_widget.dart';

enum SingingCharacter { lafayette, jefferson }

class SigninSignout extends StatefulWidget {
  const SigninSignout({super.key});

  @override
  State<SigninSignout> createState() => _SigninSignoutState();
}

class _SigninSignoutState extends State<SigninSignout> {
  final textEditingController = TextEditingController();
  double? height;
  double? width;
  var email = "";
  var password = "";
  var number = "";
  var retypePassword = "";
  var fname = "";
  var lname = "";
  bool isSelected = false;
  SingingCharacter? _character = SingingCharacter.lafayette;
  bool signed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            width: 375.w,
            height: 69.h,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                backgroundColor: Colors.transparent,
                centerTitle: false,
                title: Image(
                  image: AssetImage(AssetImages.appLogo),
                ),
                // Image.asset(
                // AssetImages.appLogo,
                // fit: BoxFit.contain,
                // height: 32.h,
                // ),
                actions: [
                  TextButton(
                    onPressed: () {
                      showSignInSignOut();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            color: AppColors.colorBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: backScreenBoday(),
    );
  }

  showSignInSignOut() {
    return showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      //isScrollControlled:true,

      context: context,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Column(
          children: [
            signed == false ? signInWidgetBody() : SignUpWidgetBody(),
          ],
        );
      },
    );
  }

  Widget signInWidgetBody() {
    // height: MediaQuery.of(context).size.height * 0.70;
    return Container(
      height: MediaQuery.of(context).size.height * 0.56,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                    child: CustomHeading(text: 'Welcome To TaskShift')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.055,
              ),
              Form(
                // key: _formkey2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.025,
                      ),
                      Material(
                        elevation: 1.0,
                        //  shadowColor: Colors.grey[700],

                        child: Container(
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),

                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 234, 232, 232),
                                offset: Offset(0.0, 0.0),
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: costomTextField(
                            textEditingController: textEditingController,
                            hintText: "Email",
                            icon: const Icon(
                              Icons.email,
                              color: AppColors.colorGrey,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.050,
                      ),
                      Material(
                        elevation: 1.0,
                        // shadowColor: Colors.grey[700],

                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 234, 232, 232),
                                offset: Offset(0.0, 0.0),
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: costomTextField(
                            textEditingController: textEditingController,
                            hintText: "Password",
                            icon: const Icon(
                              Icons.lock,
                              color: AppColors.colorGrey,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // children: [

                          InkWell(
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<SingingCharacter>(
                                  value: SingingCharacter.lafayette,
                                  groupValue: _character,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) => AppColors.colorBlue,
                                  ),
                                  //activeColor: Color(0xFF80D8FF),
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                    });

                                    // ignore: unused_label
                                    onTap:
                                    () {
                                      setState(() {
                                        _character = value;
                                      });
                                    };
                                  },
                                ),
                                CustomNormalText(text: 'Remember Me'),
                              ],
                            ),
                          ),
                          //working for arrow button
                          TextButton(
                            onPressed: () {},
                            child: CustomText(text: 'Forgot Password?'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Row(
                                children: [
                                  CustomHeading(text: 'Sign In'),
                                ],
                              ),
                            ),
                          ),
                          //working for arrow button
                          const SizedBox(width: 15),
                          InkWell(
                              child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: FloatingActionButton(
                              backgroundColor: AppColors.colorBlue,
                              child: Image.asset(
                                'assets/images/ArrowRight.png',
                                width: 50,
                                height: 50,
                              ),
                              onPressed: () async {},
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width * 0.10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customInkWell(
                    image: AssetImages.googleImage,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.11,
                  ),
                  customInkWell(
                    image: AssetImages.appleImage,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.11,
                  ),
                  customInkWell(
                    image: AssetImages.facebookImage,
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width * 0.016,
              ),
              InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomNormalText(text: 'Already have an account?'),
                      CustomText(text: ' Sign Up'),
                    ],
                  ),
                  onTap: () {
                    // Navigator.pop(context);

                    setState(() {
                      Navigator.pop(context);
                      SignUpWidgetBody();
                    });
                  })
            ],
          )),
        ),
      ),
    );
  }

  SignUpWidgetBody() {
    return showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.white,
      //................giving top right and left radius to bottomsheet.................
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return SingleChildScrollView(
          //reverse: true,

          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              // width: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0)),
              ),
              child: SingleChildScrollView(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.020,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: CustomHeading(text: 'Register your Account'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.010,
                    ),

                    Form(
                      // key: _formkey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.060,
                            ),
                            Material(
                              elevation: 1.0,
                              //shadowColor: Colors.grey[700],

                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 232, 232),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: costomTextField(
                                    textEditingController:
                                        textEditingController,
                                    hintText: 'First Name',
                                    icon: const Icon(
                                      Icons.person,
                                      color: AppColors.colorGrey,
                                      size: 20.0,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Material(
                              elevation: 1.0,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 232, 232),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: costomTextField(
                                    textEditingController:
                                        textEditingController,
                                    hintText: 'Last Name',
                                    icon: const Icon(
                                      Icons.person,
                                      color: AppColors.colorGrey,
                                      size: 20.0,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Material(
                              elevation: 1.0,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 232, 232),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: costomTextField(
                                    textEditingController:
                                        textEditingController,
                                    hintText: 'Email',
                                    icon: const Icon(
                                      Icons.email,
                                      color: AppColors.colorGrey,
                                      size: 20.0,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Material(
                              elevation: 1.0,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 232, 232),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: costomTextField(
                                    textEditingController:
                                        textEditingController,
                                    hintText: 'Password',
                                    icon: const Icon(
                                      Icons.lock,
                                      color: AppColors.colorGrey,
                                      size: 20.0,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Material(
                              elevation: 1.0,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 232, 232),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 4.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: costomTextField(
                                    textEditingController:
                                        textEditingController,
                                    hintText: 'Confirmed Password',
                                    icon: const Icon(
                                      Icons.lock,
                                      color: AppColors.colorGrey,
                                      size: 20.0,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Material(
                              elevation: 1.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 234, 232, 232),
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.colorBlue,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  //  value: atype,
                                  items: [
                                    DropdownMenuItem(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: CustomNormalText(
                                              text: "Your Role"),
                                          // Text(
                                          //   "Your Role",
                                          //   style: TextStyle(
                                          //       color: Colors.grey[500]),
                                          // ),
                                        ),
                                        value: 'Your Role'),
                                    DropdownMenuItem(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child:
                                              CustomNormalText(text: "Client"),
                                        ),
                                        value: 'client'),
                                    DropdownMenuItem(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: CustomNormalText(
                                              text: "freelancer"),
                                        ),
                                        value: 'freelancer'),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      // atype = value;
                                      print(value);
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.015,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 0),
                              InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Radio<SingingCharacter>(
                                        value: SingingCharacter.lafayette,
                                        groupValue: _character,
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              Color.fromRGBO(47, 85, 212, 1),
                                        ),
                                        //activeColor: Color(0xFF80D8FF),
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });

                                          onTap:
                                          () {
                                            setState(() {
                                              _character = value;
                                            });
                                          };
                                        },
                                      ),

                                      CustomNormalText(text: 'I agree to the'),
                                      // const Text(
                                      //   'I agree to the',
                                      //   style: TextStyle(
                                      //     color: Colors.grey,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 11,
                                      //   ),
                                      // ),
                                      CustomText(text: ' Terms Of Service'),
                                      // const Text(
                                      //   ' Terms Of Service',
                                      //   style: TextStyle(
                                      //       color:
                                      //           Color.fromRGBO(47, 85, 212, 1),
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 11),
                                      // )
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigator.pop(context);

                                    setState(() {
                                      // scrollController.position.minScrollExtent;
                                      //  scrollController.dispose();
                                      Navigator.pop(context);
                                      //  showabc(); // if (signed == true) {
                                      //   signed = false;
                                      // } else {
                                      //   signed = true;
                                      // }
                                    });
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => SignIn()),
                                    // );
                                  }),
                              InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomNormalText(text: ' and'),
                                      // Text(
                                      //   ' and',
                                      //   style: TextStyle(
                                      //     color: Colors.grey,
                                      //     fontWeight: FontWeight.w700,
                                      //     fontSize: 11,
                                      //   ),
                                      // ),
                                      CustomText(text: ' Privacy Of Policy'),
                                      // Text(
                                      //   ' Privacy Of Policy',
                                      //   style: TextStyle(
                                      //       color:
                                      //           Color.fromRGBO(47, 85, 212, 1),
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 11),
                                      // )
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigator.pop(context);

                                    setState(() {
                                      // scrollController.position.minScrollExtent;
                                      //  scrollController.dispose();
                                      Navigator.pop(context);
                                      //  showabc(); // if (signed == true) {
                                      //   signed = false;
                                      // } else {
                                      //   signed = true;
                                      // }
                                    });
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => SignIn()),
                                    // );
                                  }),
                            ]),
                      ),
                    ),
                    //google//google

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.013,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //radio check for remember your password
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 0),
                          child: Row(
                            children: [
                              CustomHeading(text: 'Sign Up'),
                            ],
                          ),
                        ),
                        //working for arrow button

                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromRGBO(47, 85, 212, 1),
                            child: Image.asset(
                              'assets/images/ArrowRight.png',
                              width: 50,
                              height: 50,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customInkWell(
                          image: AssetImages.googleImage,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.11,
                        ),
                        customInkWell(
                          image: AssetImages.appleImage,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.11,
                        ),
                        customInkWell(
                          image: AssetImages.facebookImage,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.030,
                    ),
                    InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CustomNormalText(
                                    text: 'Already have an account?'),
                              ],
                            ),
                            // Text(
                            //   'Already have an account?',
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 15,
                            //   ),
                            // ),
                            CustomText(text: 'Sign In'),
                            // Text(
                            //   ' Sign In',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w700,
                            //       color: Color.fromRGBO(47, 85, 212, 1),
                            //       fontFamily: 'Nunito',
                            //       fontSize: 15),
                            // )
                          ],
                        ),
                        onTap: () {
                          // Navigator.pop(context);

                          setState(() {
                            // scrollController.position.minScrollExtent;
                            //  scrollController.dispose();
                            //  Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SignIn()),
                            // );
                            //   }
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SignIn()),
                          // );
                        }), //google logo
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}
