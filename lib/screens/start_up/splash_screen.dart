import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/home_page.dart';
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
    super.initState();
    setTime();
  }

  void setTime() {
    const duration = Duration(seconds: 2);
    timer = Timer(duration, route);
  }

  void route() {
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => const LoginPage()),
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Full-screen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/27dd97a56537b1c5dca7472d84b71baf 1.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🌕 Ellipse glow at bottom center
          Positioned(
            bottom: 0,
            left: 0,

            child: Center(
              child: Image.asset(
                'assets/images/Ellipse 16.png',
                width: 800,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,

            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/Ellipse 16.png',
                width: 800,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌙 Bottom-right decoration (mirrored)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              child: Image.asset(
                'assets/images/Group 16.png',
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🎯 Center logo and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/favicon/Exam Portal Logo.png',
                  height: 201,
                  width: 204,
                ),
                const SizedBox(height: 5),
                CustomText(
                  title: "Welcome to Exam Portal",
                  size: 20.0,
                  color: AppColors.primaryWhite,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                CustomText(
                  title: "Practice smarter with AI powered quizzes",
                  size: 14.0,
                  color: AppColors.primaryWhite,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
