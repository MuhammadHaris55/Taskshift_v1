import 'package:flutter/material.dart';

String uri = 'https://taskshift.com';
// String uri = 'http://taskshift.test';
// String uri = 'http://taskshift.test:30001';
// String uri = 'http://192.168.100.9:30001'; // For real device
// String uri = 'http://192.168.100.9:1337';
// String uri = 'http://192.168.100.9:30001';
// String uri = 'http://192.168.100.9:3000';
// String uri = 'http://192.168.100.9:8000';
// String uri = 'http://192.168.100.9:8080';

const String appFontFamily = 'Nunito';

class Apis {
  static String signUp = '$uri/api/signup';
  static String login = '$uri/api/login';
  static String googleLogin = '$uri/api/login/google/callback';
  // static String getUserData = '$uri/api/authenticated/user'; // ----previous api
  static String getUserData = '$uri/api/authenticated/user/mobile';
  static String getChat = '$uri/api/getchat';
  static String getMessage = '$uri/api/getmessages';
  static String sendMessage = '$uri/api/createmessage';
  static String msgStatusRead = '$uri/api/readstatusmessage';
  static String maintainOnlineStatus = '$uri/api/set-user-online';
}

class AssetImages {
  // static String googleLogo = 'assets/images/google.jpg';  //  From Faiz --white background
  static String googleLogo =
      'assets/images/google.png'; //  From internet --transparent background
  static String appleLogo = 'assets/images/apple.jpg';
  static String facebookLogo = 'assets/images/facebook.jpg';
  // static String appLogo = 'assets/images/Taskshift_logo.png';  // It is blur
  static String appLogo = 'assets/images/appLogo.png';
  static String backscreen = 'assets/images/backscreen.png';
  static String userDP = 'assets/images/imagesForChat/user-dp.png';
}

class AppColors {
  static const backgroundColor = Colors.white;
  static const Color colorGrey = Color.fromRGBO(142, 142, 142, 1);
  static const Color colorBlue = Color.fromRGBO(47, 85, 212, 1);
  static const Color colorBlack = Colors.black;
  // static const Color greyAppBarBackgroundColor =
  //     Color.fromARGB(255, 241, 241, 244);
}

class ChatMaterial {
  static String userDP = 'assets/images/imagesForChat/user-dp.png';
  static const List<Map<String, String>> inboxDataList = [
    {
      'name': 'geo10120',
      'image': 'assets/images/imagesForChat/geo10120.png',
      'msg': 'Welcome dude',
    },
    {
      'name': 'evpartsguy',
      'image': 'assets/images/imagesForChat/evpartsguy.png',
      'msg': 'Hello, I really like your gig...',
    },
    {
      'name': 'aspire2026',
      'image': 'assets/images/imagesForChat/aspire2026.png',
      'msg': 'Hi, I need your service. Are...',
    },
    {
      'name': 'asemnaveed',
      'image': 'assets/images/imagesForChat/asemnaveed.png',
      'msg': 'Sent you a document',
    },
    {
      'name': 'traynorthern',
      'image': 'assets/images/imagesForChat/traynorthern.png',
      'msg': 'Sent you a image',
    },
    {
      'name': 'evpartsguy',
      'image': 'assets/images/imagesForChat/evpartsguy.png',
      'msg': 'Hello, I really like your gig...',
    },
    {
      'name': 'aspire2026',
      'image': 'assets/images/imagesForChat/aspire2026.png',
      'msg': 'Hi, I need your service. Are...',
    },
    {
      'name': 'asemnaveed',
      'image': 'assets/images/imagesForChat/asemnaveed.png',
      'msg': 'Sent you a document',
    },
    {
      'name': 'traynorthern',
      'image': 'assets/images/imagesForChat/traynorthern.png',
      'msg': 'Sent you a image',
    },
  ];

  static const List<Map<String, String>> messagesList = [
    {
      'id': '1',
      'msg': 'hi',
    },
    {
      'id': '2',
      'msg': 'hello',
    },
    {
      'id': '1',
      'msg': 'how are you ?',
    },
    {
      'id': '2',
      'msg': 'I\'m good',
    },
    {
      'id': '2',
      'msg': 'What about you?',
    },
    {
      'id': '1',
      'msg': 'I\'m fine, thank you',
    },
    {
      'id': '2',
      'msg': 'great',
    },
    {
      'id': '2',
      'msg': '?',
    },
    {
      'id': '1',
      'msg': 'yes',
    },
    {
      'id': '2',
      'msg':
          'I am learning flutter to create Mobile apps, are you willing to learn fluter with me?',
    },
    {
      'id': '1',
      'msg':
          'Yeah, sure why not, I am more than happy to work with you. When will you starting it',
    },
    {
      'id': '1',
      'msg': '?',
    },
  ];
}
