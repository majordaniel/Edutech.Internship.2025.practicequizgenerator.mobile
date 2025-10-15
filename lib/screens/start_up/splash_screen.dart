import 'dart:async';

import 'package:flutter/material.dart';


import '../../constant/color.dart';
import '../../widgets/custom_text.dart';
import '../auth/login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    setTime();
    super.initState();
  }

  setTime() {
    const duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/favicon/Exam Portal Logo.png',
              height: 201,
              width: 204,
            ),
            CustomText(
              title: "Practice Quiz Generator",
              size: 20.0,
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
