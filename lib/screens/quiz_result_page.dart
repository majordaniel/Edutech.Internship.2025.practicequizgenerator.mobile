import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

class QuizResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int totalScore;
  final List<Map<String, dynamic>> questionReview;

  const QuizResultPage({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.totalScore,
    required this.questionReview,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: CustomText(
          title: "Quiz Result",
          size: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDeepBlack,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Score Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomText(
                    title: "Your Grade: ${percentage.toStringAsFixed(0)}%",
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    title: "Quiz Completed",
                    size: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryLightBlack,
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard("Total Answered", "$correctAnswers/$totalQuestions"),
                      _buildStatCard("Average Performance", "${percentage.toStringAsFixed(0)}%"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Quiz Detailed Review
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                title: "Quiz Detailed Review",
                size: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDeepBlack,
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Question Review List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: questionReview.length,
              itemBuilder: (context, index) {
                final item = questionReview[index];

                // ✅ Fix: compute correctness dynamically
                final bool isCorrect =
                    item['selectedAnswer'] == item['correctAnswer'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: isCorrect ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.4),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 Question header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isCorrect ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: CustomText(
                                title: "Question ${index + 1}",
                                size: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              title: isCorrect ? "(Correct)" : "(Incorrect)",
                              size: 11,
                              color: isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🔹 Question Text
                        CustomText(
                          title: item['question'],
                          size: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDeepBlack,
                        ),

                        const SizedBox(height: 10),

                        // 🔹 Options List
                        Column(
                          children: (item['options'] as List<String>).map((option) {
                            final int correctIndex = item['correctAnswer'];
                            final int? selectedIndex = item['selectedAnswer'];
                            final bool isAnswer = item['options'].indexOf(option) == correctIndex;
                            final bool isSelected = selectedIndex != null &&
                                item['options'].indexOf(option) == selectedIndex;

                            Color borderColor;
                            Color bgColor;
                            if (isAnswer) {
                              bgColor = Colors.green.withOpacity(0.1);
                              borderColor = Colors.green;
                            } else if (isSelected && !isAnswer) {
                              bgColor = Colors.red.withOpacity(0.1);
                              borderColor = Colors.red;
                            } else {
                              bgColor = Colors.white;
                              borderColor = Colors.grey.withOpacity(0.3);
                            }

                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isAnswer
                                        ? Icons.check_circle
                                        : isSelected
                                            ? Icons.cancel
                                            : Icons.radio_button_unchecked,
                                    color: isAnswer
                                        ? Colors.green
                                        : isSelected
                                            ? Colors.red
                                            : Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomText(
                                      title: option,
                                      size: 12,
                                      color: AppColors.primaryLightBlack,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 🔹 Buttons Section
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonTitle: "Back Dashboard",
                    buttonColor: Colors.grey.shade300,
                    textColor: AppColors.primaryDeepBlack,
                    textWeight: FontWeight.w600,
                    textSize: 13,
                    buttonHeight: 44,
                    borderRadius: 8,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    buttonTitle: "Retake Quiz",
                    buttonColor: AppColors.primaryOrange,
                    textColor: Colors.white,
                    textWeight: FontWeight.w600,
                    textSize: 13,
                    buttonHeight: 44,
                    borderRadius: 8,
                    onTap: () {
                      // TODO: Add retake logic here
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        CustomText(
          title: title,
          size: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryLightBlack,
        ),
        const SizedBox(height: 4),
        CustomText(
          title: value,
          size: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDeepBlack,
        ),
      ],
    );
  }
}
