import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/features/auth/auth_screen.dart';
import 'package:taskshift_v1/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'taskshift',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorBlue,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            fontFamily: 'Nunito',
            //   primarySwatch: Colors.blue,
            // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      // () => Navigator.pushNamed(context, AuthScreen.routeName),
      () => Navigator.pushReplacementNamed(context, AuthScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0),
          const Spacer(),
          Image.asset(
            AssetImages.appLogo,
            width: 600,
          ),
          const Spacer(),
          const Text(
            'Version 1.0',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: AppColors.colorGrey,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
