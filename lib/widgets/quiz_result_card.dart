import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'custom_text.dart';
import 'custom_button.dart';

class QuizResultCard extends StatelessWidget {
  final String quizTitle;
  final String subject;
  final String
  quizDetails; // e.g., "20 Questions | 30 minutes | Quiz Completed"
  final String score; // e.g., "75% Correct"
  final String date; // e.g., "08/09/2025"
  final VoidCallback onViewResult;
  final VoidCallback? onExpand; // optional for dropdown icon action

  const QuizResultCard({
    super.key,
    required this.quizTitle,
    required this.subject,
    required this.quizDetails,
    required this.score,
    required this.date,
    required this.onViewResult,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: quizDetails,
              size: 12,
              color: AppColors.primaryLightBlack,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: quizTitle,
                      size: 12,
                      color: AppColors.primaryLightBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      title: subject,
                      size: 10,
                      color: AppColors.primaryLightBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      title: score,
                      size: 16,
                      color: AppColors.primaryLightBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),

                // Right Column
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        title: date,
                        size: 10,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 73,
                            child: CustomButton(
                              buttonTitle: "View Result",
                              textColor: AppColors.primaryWhite,
                              textWeight: FontWeight.w500,
                              textSize: 9.03,
                              buttonHeight: 25.04,
                              onTap: onViewResult,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onExpand,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
