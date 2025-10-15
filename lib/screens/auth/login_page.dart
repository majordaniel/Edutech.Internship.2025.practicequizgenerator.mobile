import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/start_up/bottom_nav.dart';

import '../../constant/color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  Widget checkbox() {
    return Checkbox(
      value: _rememberMe,
      onChanged: (bool? value) {
        setState(() {
          _rememberMe = value ?? false;
        });
      },
      activeColor: AppColors.primaryOrange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Background Image.png",
            ), // your image
            fit: BoxFit.cover, // makes it cover the entire screen
          ),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/favicon/Exam Portal Logo.png',
                  height: 201,
                  width: 204,
                ),
                CustomText(
                  title: "Welcome to Exam Portal",
                  size: 20,
                  color: AppColors.primaryDeepBlack,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 10),
                CustomText(
                  title: "Enter your credentials to access your dashboard",
                  size: 12,
                  color: AppColors.primaryLightBlack,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        title: "Student ID / Email",
                        size: 16,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 10,
                        ),
                        hintText: "Enter your Student ID / or email Address",
                        hintStyle: TextStyle(
                          color: AppColors.primaryGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        title: "Password",
                        size: 16,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.primaryGrey,
                        ),
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: AppColors.primaryGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        checkbox(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const ForgotPassword(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const ForgotPassword(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      buttonTitle: "Sign In",
                      textColor: AppColors.primaryWhite,
                      textWeight: FontWeight.w700,
                      textSize: 20.0,
                      buttonHeight: 44.0,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BottomNavbar(),
                          ),
                        );
                      },
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
