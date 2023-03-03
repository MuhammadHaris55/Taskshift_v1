import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/widgets/bottom_bar.dart';
import 'constants/global_variables.dart';
import 'features/auth/auth_screen.dart';
import 'providers/inboxList_provider.dart';
import 'providers/user_provider.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InboxListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
// void main() => runApp(MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => UserProvider(),
//         ),
//       ],
//       child: const MyApp(),
//     ));

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
            fontFamily: appFontFamily,
            //   primarySwatch: Colors.blue,
            // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),

            // -------------------------------------------------------------------------
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xffffffff),
              iconColor: AppColors.colorGrey,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle:
                  const TextStyle(color: Color(0xfff1f2ef), fontSize: 18),
              hintStyle: const TextStyle(
                color: AppColors.colorGrey,
                fontFamily: appFontFamily,
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              border: DecoratedInputBorder(
                shadow: const BoxShadow(
                  color: Color.fromRGBO(142, 142, 142, 0.5),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
                child: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  // borderSide: const BorderSide(
                  //   color: Color.fromRGBO(142, 142, 142, 0.1),
                  //   width: 0.2,
                  // ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            // -------------------------------------------------------------------------
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
    nextScreen();
    // Timer(
    //   const Duration(seconds: 3),
    //   () => Provider.of<UserProvider>(context).user.apiToken.isNotEmpty
    //       ? Navigator.pushReplacementNamed(context, BottomBar.routeName)
    //       : Navigator.pushNamed(context, AuthScreen.routeName),
    // );
  }

  nextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-auth-token') ?? '';

    Timer(
      const Duration(seconds: 3),
      () => token != ''
          ? Navigator.pushReplacementNamed(context, BottomBar.routeName)
          : Navigator.pushReplacementNamed(context, AuthScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}

// ----------------------------------------------------------------

/// You can use the same class from package https://pub.dev/packages/control_style
/// instead of implementing the class in your project
class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t)!,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => hashValues(borderSide, child, shadow);
}

// ----------------------------------------------------------------

