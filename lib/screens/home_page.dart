import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';
import 'package:quiz_generator/widgets/dashboard_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16, // size of the circle
                    backgroundImage: AssetImage('assets/images/Ellipse 1.png'),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.plusJakartaSans().fontFamily,
                              fontSize: 14,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            "Monday,",
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.plusJakartaSans().fontFamily,
                              fontSize: 14,
                              color: AppColors.primaryDeepBlack,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
                      CustomText(
                        title: "ST ID:MAT-0098-23402025",
                        size: 10,
                        color: AppColors.primaryLightBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.notifications_none,
                    color: AppColors.primaryBlack,
                    size: 24.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightOrange,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/baa90d53ce81418c61c575ea58c32b6a6851a879.png",
                    ), // your image
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    scale: 0.4, // makes it cover the entire screen
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 6.0,
                          ),
                          child: CustomText(
                            title: "Introducing",
                            size: 10,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        CustomText(
                          title: 'AI Practice Quiz Generator',
                          size: 16,
                          color: AppColors.primaryDeepBlack,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 8.0),
                        SizedBox(
                          width: 300,
                          child: CustomText(
                            title:
                                'Create a custom quiz and get exam ready with practice questions tailored to you.....',
                            size: 10,
                            color: AppColors.primaryDeepBlack,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: CustomButton(
                                  buttonTitle: 'Take a Practice Quiz Now',
                                  textColor: AppColors.primaryWhite,
                                  textWeight: FontWeight.w500,
                                  textSize: 12,
                                  buttonHeight: 16,
                                  onTap: () {
                                    // Handle button tap
                                  },
                                  buttonColor: AppColors.primaryOrange,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/online-survey-3d-render-laptop-form-with-ticks 1.png',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 170,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  DashboardCard(
                    title: "Active Courses",
                    value: "00",
                    iconPath: "assets/icons/Document.png",
                  ),
                  const SizedBox(width: 20),
                  DashboardCard(
                    title: "Assigned Exam",
                    value: "00",
                    iconPath: "assets/icons/Document.png",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  DashboardCard(
                    title: "Exam Taken",
                    value: "00",
                    iconPath: "assets/icons/Document.png",
                  ),
                  const SizedBox(width: 20),
                  DashboardCard(
                    title: "Avg. Performance",
                    value: "00",
                    iconPath: "assets/icons/Document.png",
                  ),
                ],
              ),

              SizedBox(height: 16),
              CustomText(
                title: "Your Activity",
                size: 16,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 5),
              Expanded(
                child: Card(
                  elevation: 1, // controls the shadow depth
                  color: AppColors.primaryWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // rounded corners
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 40.0, 5.0, 40.0),
                      child: Column(
                        children: [
                          Container(
                            height: 59.88,
                            width: 59.88,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Color(0xFFFEF0EA),
                            ),
                            child: ImageIcon(
                              AssetImage(
                                'assets/images/learning-tools_18843128 1.png',
                              ),
                              size: 35.22,
                              color: AppColors.primaryDeepBlack,
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomText(
                            title: "Your Exam Activity & Progress",
                            size: 12,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 6),
                          CustomText(
                            title: "You haven’t attempted any exams yet. ",
                            size: 10,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            title:
                                "Start with a practice quiz to build confidence before yourfirst test.",
                            size: 10,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
