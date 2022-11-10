import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/features/auth/services/social_auth_services.dart';

class SocialMediaLoginRow extends StatefulWidget {
  const SocialMediaLoginRow({super.key});

  @override
  State<SocialMediaLoginRow> createState() => _SocialMediaLoginRowState();
}

class _SocialMediaLoginRowState extends State<SocialMediaLoginRow> {
  final GoogleSignIn _googlesignin = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SocialAuthServices socialAuthServices = SocialAuthServices();

  GoogleSignInAccount? _currentUser;

  // @override
  Future<void> signIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googlesignin.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _auth.signInWithCredential(credential);

      var profileData = authResult.additionalUserInfo;
      if (profileData != null) {
        socialAuthServices.googleLogin(
          context: context,
          email: profileData.profile!['email'],
          providerId: profileData.profile!['sub'],
          fullName: profileData.profile!['name'],
        );
      }
      
    } catch (e) {
      print('ERROR SIGNING IN $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            signIn(context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              AssetImages.googleLogo,
            ),
            radius: 25.0.w,
          ),
          // Image.asset(
          //   AssetImages.googleLogo,
          //   width: 45.0.w,
          // ),
        ),
        SizedBox(width: 37.0.w),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.apple_outlined,
            color: Colors.black,
            size: 50.0.w,
          ),
        ),
        SizedBox(width: 37.0.w),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.facebook_rounded,
            color: const Color.fromRGBO(66, 103, 178, 1),
            size: 45.0.w,
          ),
        )
      ],
    );
  }
}
