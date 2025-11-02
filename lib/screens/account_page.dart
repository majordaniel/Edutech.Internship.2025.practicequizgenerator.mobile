import 'package:flutter/material.dart';
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
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 5),
                          const Spacer(),
                          Icon(
                            Icons.notifications_none,
                            color: AppColors.primaryBlack,
                            size: 24.0,
                          ),
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
                        iconPath: 'assets/icons/Union.png',
                        onTap: () {
                          // navigate or perform action
                        },
                      ),

                      SizedBox(height: 8.0),
                      CustomCardTile(
                        title: "Contact Us",
                        iconPath: 'assets/icons/Union.png',
                        onTap: () {
                          // navigate or perform action
                        },
                      ),

                      SizedBox(height: 24.0),

                      CustomButton(
                        image: Image.asset(
                          "assets/icons/Logout.png",
                          color: AppColors.primaryWhite,
                        ),
                        buttonTitle: "Sign Out",
                        textColor: AppColors.primaryWhite,
                        textWeight: FontWeight.w600,
                        textSize: 16,
                        buttonHeight: 44,
                        onTap: () {
                          CustomDialog(
                            icon: Icons.check_circle_outline,
                            iconPath: 'assets/icons/Edit Square.png',
                            title: "Signing Out",
                            message:
                                "Are you sure you want to sign out from Exam Portal?",
                            secondaryButtonText: "Not Yet",
                            primaryButtonText: "Sign Out",
                            primaryButtonColor: AppColors.primaryOrange,
                            primaryBorderColor: AppColors.primaryOrange,
                            secondaryBorderColor: AppColors.primaryOrange,
                            // ✅ Add consistent padding inside the dialog
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            // ✅ Properly align buttons at the bottom with spacing
                            buttonAlignment: MainAxisAlignment.spaceBetween,
                            onSecondaryPressed: () {
                              Navigator.pop(context);
                            },

                            // onPrimaryPressed: () {
                            //   if (mounted) {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return QuizScreen(
                            //             quiz: quiz!,
                            //             duration: Duration(
                            //               minutes: minutes,
                            //               seconds: seconds,
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   }
                            // },
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
