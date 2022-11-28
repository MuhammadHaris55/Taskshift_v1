import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:linkedin_login/linkedin_login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class SocialAuthServices {
  //------------------------------------------ Pre Google login START ----------------------------------------
  final GoogleSignIn _googlesignin = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _currentUser;

  // @override
  Future<void> preGoogleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googlesignin.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      print("auth cred ---> ${googleSignInAuthentication.toString()}");
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _auth.signInWithCredential(credential);

      var profileData = authResult.additionalUserInfo;
      if (profileData != null) {
        socialLogins(
          context: context,
          email: profileData.profile!['email'],
          providerId: profileData.profile!['sub'],
          fullName: profileData.profile!['name'],
          api: Apis.googleLogin,
        );
      }
    } catch (e) {
      print('ERROR SIGNING IN $e');
      Navigator.pop(context);
      showSnackBar(context, 'Server issue');
    }
  }
  //------------------------------------------ Pre Google login END ----------------------------------------

  //------------------------------------------ Pre LinkedIn login START --------------------------------------
  // late UserObject? user = new UserObject();
  // late AuthCodeObject? authorizationCode = new AuthCodeObject();
  bool logoutUser = false;

  final String redirectUrl =
      'https://www.linkedin.com/developers/tools/oauth/redirect';
  final String clientId = '77ywlo36hrljlk';
  final String clientSecret = 'qNeoNHZ0cvAWazKe';

  Future<void> preLinkedInLogin(BuildContext context) async {
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

            String? providerId = linkedInUser.user.userId;
            String? email =
                linkedInUser.user.email?.elements![0].handleDeep?.emailAddress;
            String? fullName =
                '${linkedInUser.user.localizedFirstName.toString()} ${linkedInUser.user.localizedLastName.toString()}';

            if (email != null && providerId != null) {
              socialLogins(
                context: context,
                providerId: providerId,
                fullName: fullName,
                email: email,
                api: Apis.linkedinLogin,
              );
            } else {
              showSnackBar(context, 'Crendential or server error');
            }
            // print('User id: ${linkedInUser.user.userId}');
            // // print('USer DATA : ' + linkedInUser.user.toString());
            // print(
            //     'USer email : ${linkedInUser.user.email?.elements![0].handleDeep?.emailAddress}');
            // print(
            //     'USer name : ${linkedInUser.user.localizedFirstName.toString()}');
            // print(
            //     'USer lastName : ${linkedInUser.user.localizedLastName.toString()}');

            // user = UserObject(
            //   firstName: linkedInUser.user.firstName?.localized?.label,
            //   lastName: linkedInUser.user.lastName?.localized?.label,
            //   email: linkedInUser
            //       .user.email?.elements![0].handleDeep?.emailAddress,
            //   profileImageUrl: linkedInUser
            //       .user
            //       .profilePicture
            //       ?.displayImageContent
            //       ?.elements![0]
            //       .identifiers![0]
            //       .identifier,
            // );
            Navigator.pop(context);
          },
        ),
        fullscreenDialog: true,
      ),
    );
  }

  //------------------------------------------ Pre LinkedIn login END ----------------------------------------

  void socialLogins({
    required BuildContext context,
    required String providerId,
    required String fullName,
    required String email,
    required String api,
  }) async {
    try {
      print('In try --- $fullName --- $email ---- $providerId' + providerId);
      http.Response res = await http.post(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "providerId": providerId,
          "email": email,
          "fullName": fullName,
        }),
      );
      print('response ---> ' + jsonDecode(res.body).toString());

      if (jsonDecode(res.body)['success']) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            print('error handling');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonEncode(jsonDecode(res.body)['response']));
            await prefs.setString('x-auth-token',
                jsonDecode(res.body)['response']['api_token'].toString());
            await prefs.setInt(
                'userId', jsonDecode(res.body)['response']['id']);
            // --------------------------------------------
            await prefs.setString(
              'image',
              jsonDecode(res.body)['response']['image'] == null ||
                      jsonDecode(res.body)['response']['image'] == ''
                  ? 'https://profiles.ucr.edu/app/images/default-profile.jpg'
                  : '$uri${jsonDecode(res.body)['response']['image']}',
            );
            await prefs.setStringList('profile', [
              jsonDecode(res.body)['response']['image'] == null ||
                      jsonDecode(res.body)['response']['image'] == ''
                  ? 'https://profiles.ucr.edu/app/images/default-profile.jpg'
                  : '$uri${jsonDecode(res.body)['response']['image']}',
              jsonDecode(res.body)['response']['display_name'],
              jsonDecode(res.body)['response']['profileviewas'],
              jsonDecode(res.body)['response']['first_name'],
              jsonDecode(res.body)['response']['last_name'],
              jsonDecode(res.body)['response']['email'],
            ]);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          },
        );
      } else {
        Navigator.pop(context);
        showSnackBar(context, jsonDecode(res.body)['response']);
      }
    } catch (e) {
      print("catch");
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }
}
