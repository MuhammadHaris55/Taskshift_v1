// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskshift_v1/features/auth/auth_screen.dart';

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
    print(
        'name $name -- l_name $lastName --- email $email ----password $password ---- p confirm $passwordConfirmation ---- type $role');

    // Navigator.pushNamed(context, AuthScreen.routeName);
    Navigator.pop(context);
    showSnackBar(context, 'Successfully registerated');
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
    // print('email $email ----- password $password');
    // Navigator.pushNamedAndRemoveUntil(
    //     context, BottomBar.routeName, (route) => false);

    try {
      print('In try');
      http.Response res = await http.post(
        Uri.parse(Apis.login),
        body: {
          'email': email,
          'password': password,
        },
        // headers: <String, String>{
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   'Content-Type': 'application/json',
        // },
      );
      print('response ---> ' + jsonDecode(res.body).toString());
      print('response without decode ---> ' +
          jsonEncode(jsonDecode(res.body)['response']));

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
          // --------------------------------------------
          await prefs.setString(
              'image', jsonDecode(res.body)['response']['image']);
          await prefs.setStringList('profile', [
            jsonDecode(res.body)['response']['image'],
            jsonDecode(res.body)['response']['display_name'],
            jsonDecode(res.body)['response']['profileviewas'],
            jsonDecode(res.body)['response']['first_name'],
            jsonDecode(res.body)['response']['last_name'],
            jsonDecode(res.body)['response']['email'],
          ]);
          // await prefs.setString('email', jsonDecode(res.body)['email']);
          // await prefs.setString(
          //     'first_name', jsonDecode(res.body)['first_name']);
          // await prefs.setString('last_name', jsonDecode(res.body)['last_name']);
          // await prefs.setString(
          //     'display_name', jsonDecode(res.body)['display_name']);
          // await prefs.setString(
          //     'profileviewas', jsonDecode(res.body)['profileviewas']);
          // --------------------------------------------
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      print("catch");
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      // var tokenRes = await http.post(
      //   Uri.parse('$uri/tokenIsValid'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'x-auth-token': token!
      //   },
      // );

      // var response = jsonDecode(tokenRes.body);

      if (token != '') {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(jsonEncode(jsonDecode(userRes.body)['response']));
      } else {
        return;
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // ------------------- Shared Preference getData
  // getData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? email = prefs.getString('email');
  //   String? firstName = prefs.getString('first_name');
  //   String? lastName = prefs.getString('last_name');
  //   String? displayName = prefs.getString('display_name');
  //   String? profileviewas = prefs.getString('profileviewas');
  //   var user = {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'displayName': displayName,
  //     'email': email,
  //     'profileviewas': profileviewas,
  //   };
  //   return user;
  // }
  // ------------------- Shared Preference getData

}
