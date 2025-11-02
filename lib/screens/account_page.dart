import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/auth/login_page.dart';
import 'package:quiz_generator/screens/contact_page.dart';
import 'package:quiz_generator/screens/profile_page.dart';
import 'package:quiz_generator/screens/start_up/bottom_nav.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import '../constant/color.dart';
import '../widgets/custom_card_tile.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Back Arrow Button
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.primaryDeepBlack,
                              size: 20,
                            ),
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavbar(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 5),
                          const Spacer(),
                        ],
                      ),
                      CustomText(
                        title: "My Account",
                        size: 20,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 8.0),
                      CustomText(
                        title: " ST ID:MAT-0098-23402025",
                        size: 10,
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 24.0),
                      CustomCardTile(
                        title: "My Profile",
                        iconPath: 'assets/icons/svg/Add User.svg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProfilePage();
                              },
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 8.0),
                      CustomCardTile(
                        title: "Contact Us",
                        iconPath: 'assets/icons/svg/Chat.svg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ContactPage();
                              },
                            ),
                          );
                        },
                      ),

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
                              // Remove the Flutter icon so SVG path is used instead
                              iconPath: 'assets/icons/svg/Edit Square.svg',

                              // Dialog Content
                              title: "Signing Out",
                              message:
                                  "Are you sure you want to sign out from Exam Portal?",

                              // Buttons
                              secondaryButtonText: "Not Yet",
                              primaryButtonText: "Sign Out",
                              primaryButtonColor: AppColors.primaryOrange,
                              primaryBorderColor: AppColors.primaryOrange,
                              secondaryBorderColor: AppColors.primaryOrange,

                              // Layout
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 18,
                              ),
                              buttonAlignment: MainAxisAlignment.spaceBetween,

                              // Actions
                              onSecondaryPressed: () {
                                Navigator.pop(context);
                              },
                              onPrimaryPressed: () {
                                Navigator.pop(context);
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
          },
        ),
      ),
    );
  }
}
