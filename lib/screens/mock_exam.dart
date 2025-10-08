import 'package:flutter/material.dart';
import 'package:quiz_generator/widgets/custom_button.dart';

import '../constant/color.dart';
import '../widgets/custom_text.dart';

class MockExam extends StatefulWidget {
  const MockExam({super.key});

  @override
  State<MockExam> createState() => _MockExamState();
}

class _MockExamState extends State<MockExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
          child: Column(
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
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 14,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            "Monday,",
                            style: TextStyle(
                             fontFamily: 'PlusJakartaSans',
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
              CustomButton(
                buttonTitle: "Create New Quiz",
                textColor: AppColors.primaryWhite,
                textWeight: FontWeight.w500,
                textSize: 16,
                buttonHeight: 32,
                onTap: () {},
                alignment: Alignment.center,
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2, // controls the shadow depth
                      color: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Active Courses",
                              size: 14,
                              color: AppColors.primaryLightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "00",
                                  size: 20,
                                  color: AppColors.primaryDeepBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                                // SizedBox(width: 80.0),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFEF0EA),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/icons/Document.png'),
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Card(
                      elevation: 2, // controls the shadow depth
                      color: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Assigned Exam",
                              size: 14,
                              color: AppColors.primaryLightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "00",
                                  size: 20,
                                  color: AppColors.primaryDeepBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                                // SizedBox(width: 80.0),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFEF0EA),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/icons/Document.png'),
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2, // controls the shadow depth
                      color: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Exam Taken",
                              size: 14,
                              color: AppColors.primaryLightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "00",
                                  size: 20,
                                  color: AppColors.primaryDeepBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                                // SizedBox(width: 80.0),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFEF0EA),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/icons/Document.png'),
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Card(
                      elevation: 2, // controls the shadow depth
                      color: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Avg. Performance",
                              size: 14,
                              color: AppColors.primaryLightBlack,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "00",
                                  size: 20,
                                  color: AppColors.primaryDeepBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                                // SizedBox(width: 80.0),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Color(0xFFFEF0EA),
                                  ),
                                  child: ImageIcon(
                                    AssetImage('assets/icons/Document.png'),
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CustomText(
                    title: "Your Activity",
                    size: 16,
                    color: AppColors.primaryDeepBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  CustomText(
                    title: "View all",
                    size: 16,
                    color: AppColors.primaryLightBlack,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5),
                ],
              ),
              Card(
                elevation: 2, // controls the shadow depth
                color: AppColors.primaryWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // rounded corners
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomText(
                    title: "20 Questions | 30 minutes | Quiz Completed",
                    size: 12,
                    color: AppColors.primaryLightBlack,
                    fontWeight: FontWeight.w500,
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
