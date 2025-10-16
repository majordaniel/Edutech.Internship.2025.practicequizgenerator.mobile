import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/mock_setup_page.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/dashboard_card.dart';
import 'package:quiz_generator/widgets/quiz_result_card.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16, // size of the circle
                      backgroundImage: AssetImage(
                        'assets/images/Ellipse 1.png',
                      ),
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MockSetupPage(),
                      ),
                    );
                  },
                  alignment: Alignment.center,
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    DashboardCard(
                      title: "Total Quizzes",
                      value: "12",
                      iconPath: "assets/icons/Document.png",
                    ),
                    const SizedBox(width: 20),
                    DashboardCard(
                      title: "Average Score",
                      value: "78%",
                      iconPath: "assets/icons/Document.png",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DashboardCard(
                      title: "Last Quiz Score",
                      value: "85%",
                      iconPath: "assets/icons/Document.png",
                    ),
                    const SizedBox(width: 20),
                    DashboardCard(
                      title: "Avg. Performance",
                      value: "1h:45m",
                      iconPath: "assets/icons/Document.png",
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
                SizedBox(height: 10),
                QuizResultCard(
                  quizTitle: "Math Practice",
                  subject: "Mathematics",
                  quizDetails: "20 Questions • 30 minutes • Completed",
                  progress: 0.8,
                  date: "Oct 16, 2025",
                  onSelectAction: (action) {
                    print("User selected: $action");
                  },
                ),

                SizedBox(height: 10),
                QuizResultCard(
                  quizTitle: "Math Practice",
                  subject: "Mathematics",
                  quizDetails: "20 Questions • 30 minutes • Completed",
                  progress: 0.8,
                  date: "Oct 16, 2025",
                  onSelectAction: (action) {
                    print("User selected: $action");
                  },
                ),

                SizedBox(height: 10),
                QuizResultCard(
                  quizTitle: "Math Practice",
                  subject: "Mathematics",
                  quizDetails: "20 Questions • 30 minutes • Completed",
                  progress: 0.8,
                  date: "Oct 16, 2025",
                  onSelectAction: (action) {
                    print("User selected: $action");
                  },
                ),

                SizedBox(height: 10),
                QuizResultCard(
                  quizTitle: "Math Practice",
                  subject: "Mathematics",
                  quizDetails: "20 Questions • 30 minutes • Completed",
                  progress: 0.8,
                  date: "Oct 16, 2025",
                  onSelectAction: (action) {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
