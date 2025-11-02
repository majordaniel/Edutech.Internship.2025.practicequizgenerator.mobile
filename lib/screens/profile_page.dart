import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/auth/login_page.dart';

import '../constant/color.dart';
import '../widgets/active_courses_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card_tile.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Back Arrow Button
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primaryDeepBlack,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 5),
                  const Spacer(),
                ],
              ),
              const CustomText(
                title: "My Profile",
                size: 20,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 8.0),
              const CustomText(
                title: "ST ID:MAT-0098-23402025",
                size: 10,
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Name",
                size: 12,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "Monday Sunday",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Email",
                size: 12,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "MondaySunday@yahoo.com",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Program",
                size: 12,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "Computer Science",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              SizedBox(height: 24.0),
              const CustomText(
                title: "Active Courses",
                size: 12,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),

              /** 
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activeCourses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomCardTile(
                      title: activeCourses[index], //You can call the active courses from the API here
                      showTrailingIcon: false,
                      backgroundColor: AppColors.primaryWhite,
                      textSize: 10,
                    ),
                  );
                },
              ),
              */
              
              ActiveCoursesCard(), //You can call the active courses from the API here
              SizedBox(height: 24.0),

              CustomButton(
                iconPath:
                    "assets/icons/svg/Logout.svg", // Use SVG icon instead of Image.asset
                iconColor: AppColors.primaryWhite,
                buttonTitle: "Sign Out",
                textColor: AppColors.primaryWhite,
                textWeight: FontWeight.w600,
                textSize: 16,
                buttonHeight: 44,
                borderRadius: 8,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      icon: Icons.logout, // optional Flutter icon
                      iconPath:
                          'assets/icons/svg/Edit Square.svg', // now supports SVG
                      title: "Signing Out",
                      message:
                          "Are you sure you want to sign out from Exam Portal?",
                      secondaryButtonText: "Not Yet",
                      primaryButtonText: "Sign Out",
                      primaryButtonColor: AppColors.primaryOrange,
                      primaryBorderColor: AppColors.primaryOrange,
                      secondaryBorderColor: AppColors.primaryOrange,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      buttonAlignment: MainAxisAlignment.spaceBetween,
                      onSecondaryPressed: () {
                        Navigator.pop(context);
                      },
                      onPrimaryPressed: () {
                        Navigator.pop(context);
                        // ✅ Safely navigate (no need for mounted check in stateless widget)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
