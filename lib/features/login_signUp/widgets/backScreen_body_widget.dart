import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget backScreenBoday() => Stack(
      children: <Widget>[
        Container(
          width: 375.w,
          height: 694.h,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/backscreen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
