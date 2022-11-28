import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/features/auth/services/social_auth_services.dart';

class SocialMediaLoginRow extends StatefulWidget {
  const SocialMediaLoginRow({super.key});

  @override
  State<SocialMediaLoginRow> createState() => _SocialMediaLoginRowState();
}

class _SocialMediaLoginRowState extends State<SocialMediaLoginRow> {
  final SocialAuthServices socialAuthServices = SocialAuthServices();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            socialAuthServices.preGoogleLogin(context);
            // signIn(context);
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
          onTap: () {
            socialAuthServices.preLinkedInLogin(context);
          },
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
