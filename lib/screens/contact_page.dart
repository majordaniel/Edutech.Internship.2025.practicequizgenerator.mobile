import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/auth/login_page.dart';

import '../constant/color.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card_tile.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_text.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
                  // Icon(
                  //   Icons.notifications_none,
                  //   color: AppColors.primaryBlack,
                  //   size: 24.0,
                  // ),
                ],
              ),
              const CustomText(
                title: "Come Say Hi!",
                size: 20,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 8.0),
              const CustomText(
                title: "We'd love to hear from you",
                size: 10,
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Phone Number",
                size: 10,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "+080 - 567-567",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Email",
                size: 10,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "customersupport@examportal.com",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              const SizedBox(height: 24.0),

              const CustomText(
                title: "Address",
                size: 10,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8.0),
              CustomCardTile(
                title: "No. 78 Adeniran ogunsanya, Surulere Lagos",
                showTrailingIcon: false,
                backgroundColor: AppColors.primaryWhite,
                textSize: 10,
              ),
              SizedBox(height: 24.0),

              CustomButton(
                iconPath:
                    "assets/icons/svg/Logout.svg", // ✅ Use SVG icon instead of Image.asset
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
                          'assets/icons/svg/Edit Square.svg', // ✅ now supports SVG
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
