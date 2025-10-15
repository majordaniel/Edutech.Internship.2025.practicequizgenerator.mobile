import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../widgets/custom_text.dart';

class AnsweredQuestions extends StatefulWidget {
  const AnsweredQuestions({super.key});

  @override
  State<AnsweredQuestions> createState() => _AnsweredQuestionsState();
}

class _AnsweredQuestionsState extends State<AnsweredQuestions> {
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
                              Navigator.pop(
                                context,
                              ); // Go back to the previous screen
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
                        title: "Set up Mock Exam",
                        size: 20,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w700,
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
