// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';


class AuthService {
// sign up user
  void userSignUp({
    required BuildContext context,
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    print('name $name -- l_name $lastName --- email $email ----password $password ---- p confirm $passwordConfirmation ---- type $role');
    // try {
    //   http.Response res = await http.post(
    //     Uri.parse(Apis.signUp),
    //     body: jsonEncode({
    //       "name": name,
    //       "last_name": lastName,
    //       "email": email,
    //       "password": password,
    //       "password_confirmation": passwordConfirmation,
    //       "type": role,
    //     },),
    //     // user.toJson(),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );

    //   if(jsonDecode(res.body)['success'])
    //   {
    //     showSnackBar(
    //       context,
    //       'Account created! Verify your email and loged in',
    //     );
    //     // showSnackBar(context, jsonDecode(res.body)['response']);
    //     // showSnackBar(context, 'Verify your email and logged in with the same credential');
    //   } else {
    //     showSnackBar(context, jsonDecode(res.body)['response']);
    //   }

    // } catch (e) {
    //   showSnackBar(context, e.toString());
    // }
  }

  // sign in user
  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    print('email $email ----- password $password');

    try {
      http.Response res = await http.post(
        Uri.parse(Apis.login),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['api_token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // //get user data
  // void getUserData(
  //   BuildContext context,
  // ) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     var tokenRes = await http.post(
  //       Uri.parse('$uri/tokenIsValid'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': token!
  //       },
  //     );

  //     var response = jsonDecode(tokenRes.body);

  //     if (response == true) {
  //       http.Response userRes = await http.get(
  //         Uri.parse('$uri/'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': token
  //         },
  //       );

  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}