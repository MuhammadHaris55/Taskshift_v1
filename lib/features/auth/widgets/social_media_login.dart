import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/features/auth/Linkedin_Auth.dart';
import 'package:taskshift_v1/features/auth/services/social_auth_services.dart';
import 'package:linkedin_login/linkedin_login.dart';

const String redirectUrl =
    'https://www.linkedin.com/developers/tools/oauth/redirect';
const String clientId = '77ywlo36hrljlk';
const String clientSecret = 'qNeoNHZ0cvAWazKe';

class SocialMediaLoginRow extends StatefulWidget {
  const SocialMediaLoginRow({super.key});

  @override
  State<SocialMediaLoginRow> createState() => _SocialMediaLoginRowState();
}

class _SocialMediaLoginRowState extends State<SocialMediaLoginRow> {
  final SocialAuthServices socialAuthServices = SocialAuthServices();
  late UserObject? user = new UserObject();
  late AuthCodeObject? authorizationCode = new AuthCodeObject();
  bool logoutUser = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            socialAuthServices.signIn(context);
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
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (final BuildContext context) => LinkedInUserWidget(
                  appBar: AppBar(
                    title: const Text('OAuth User'),
                  ),
                  destroySession: logoutUser,
                  redirectUrl: redirectUrl,
                  clientId: clientId,
                  clientSecret: clientSecret,
                  projection: const [
                    ProjectionParameters.id,
                    ProjectionParameters.localizedFirstName,
                    ProjectionParameters.localizedLastName,
                    ProjectionParameters.firstName,
                    ProjectionParameters.lastName,
                    ProjectionParameters.profilePicture,
                  ],
                  onError: (final UserFailedAction e) {
                    print('Error: ${e.toString()}');
                    print('Error: ${e.stackTrace.toString()}');
                  },
                  onGetUserProfile: (final UserSucceededAction linkedInUser) {
                    print(
                      'Access token ${linkedInUser.user.token.accessToken}',
                    );

                    print('User id: ${linkedInUser.user.userId}');
                    print('USer DATA : ' + linkedInUser.user.toString());

                    user = UserObject(
                      firstName:
                          linkedInUser?.user?.firstName?.localized?.label,
                      lastName: linkedInUser?.user?.lastName?.localized?.label,
                      email: linkedInUser
                          ?.user?.email?.elements![0]?.handleDeep?.emailAddress,
                      profileImageUrl: linkedInUser
                          ?.user
                          ?.profilePicture
                          ?.displayImageContent
                          ?.elements![0]
                          ?.identifiers![0]
                          ?.identifier,
                    );

                    setState(() {
                      logoutUser = false;
                    });

                    Navigator.pop(context);
                  },
                ),
                fullscreenDialog: true,
              ),
            );
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
