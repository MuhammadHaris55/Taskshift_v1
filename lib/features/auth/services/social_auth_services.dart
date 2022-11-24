import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class SocialAuthServices {
  final GoogleSignIn _googlesignin = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _currentUser;

  // @override
  Future<void> signIn(BuildContext context) async {
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
        googleLogin(
          context: context,
          email: profileData.profile!['email'],
          providerId: profileData.profile!['sub'],
          fullName: profileData.profile!['name'],
        );
      }
    } catch (e) {
      print('ERROR SIGNING IN $e');
      Navigator.pop(context);
      showSnackBar(context, 'Server issue');
    }
  }

  void googleLogin({
    required BuildContext context,
    required String providerId,
    required String fullName,
    required String email,
  }) async {
    try {
      print('In try --- $fullName --- $email ---- $providerId' + providerId);
      http.Response res = await http.post(
        Uri.parse(Apis.googleLogin),
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
