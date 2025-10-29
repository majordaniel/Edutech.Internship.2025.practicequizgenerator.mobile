import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/main.dart' show userController;
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';
import 'package:quiz_generator/widgets/dashboard_card.dart';
import 'package:quiz_generator/widgets/greeting_card.dart';

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16, // size of the circle
                      backgroundImage: AssetImage(
                        'assets/images/Ellipse 1.png',
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ListenableBuilder(
                      listenable: userController,
                      builder: (context, child) {
                        print('child-type=${child.runtimeType}');
                        return GreetingCard(user: userController.user);
                      },
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_none,
                      color: AppColors.primaryBlack,
                      size: 24.0,
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                Stack(
                  children: [
                    // 1️⃣ Background Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 3,
                          sigmaY: 3,
                        ), // adjust blur strength
                        child: Image.asset(
                          "assets/images/baa90d53ce81418c61c575ea58c32b6a6851a879.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 181, // or your preferred height
                        ),
                      ),
                    ),

                    // 2️⃣ Foreground Content
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(
                          0.1,
                        ), // optional overlay tint
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "Introducing",
                            size: 10,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(height: 6.0),
                          CustomText(
                            title: 'AI Practice Quiz Generator',
                            size: 16,
                            color: AppColors.primaryDeepBlack,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 8.0),
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
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    onTap: () {},
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                /// 🧾 Dashboard Cards
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

                const SizedBox(height: 20),

                /// 📊 Activity Card
                CustomText(
                  title: "Your Activity",
                  size: 16,
                  color: AppColors.primaryDeepBlack,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),

                // ❌ FIXED: No Expanded inside ScrollView
                Card(
                  elevation: 1,
                  color: AppColors.primaryWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 59.88,
                            width: 59.88,
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: const Color(0xFFFEF0EA),
                            ),
                            child: const ImageIcon(
                              AssetImage(
                                'assets/icons/learning-tools_18843128 1.png',
                              ),
                              size: 35.22,
                              color: AppColors.primaryDeepBlack,
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomText(
                            title: "Your Exam Activity & Progress",
                            size: 12,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(height: 6),
                          CustomText(
                            title: "You haven’t attempted any exams yet.",
                            size: 10,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            title:
                                "Start with a practice quiz to build confidence before your first test.",
                            size: 10,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
