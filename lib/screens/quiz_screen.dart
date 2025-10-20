import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedOption;
  late List<int?> selectedAnswers;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Which of the following is NOT a characteristic of the parliamentary system of government?",
      "options": [
        "Ministers are usually members of parliament",
        "Prime minister is the head of government",
        "Ministers are accountable to parliament",
        "Executive and legislature are separate",
      ],
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Earth", "Mars", "Jupiter", "Saturn"],
    },
    {
      "question": "What is the capital of France?",
      "options": ["London", "Berlin", "Paris", "Rome"],
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: const Text(
          "Data Science Practice Quiz",
          style: TextStyle(
            color: AppColors.primaryDeepBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: AppColors.primaryDeepBlack),
                SizedBox(width: 6),
                Text(
                  "04:45",
                  style: TextStyle(
                    color: AppColors.primaryDeepBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuizProgressBar(progress: (currentIndex + 1) / questions.length),
            const SizedBox(height: 24),

            // Question Number
            Text(
              "Question ${currentIndex + 1}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.primaryDeepBlack,
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Custom Question Card
            QuestionCard(
              question: question['question'],
              options: List<String>.from(question['options']),
              selectedIndex: selectedAnswers[currentIndex],
              onOptionSelected: (index) {
                setState(() {
                  selectedAnswers[currentIndex] = index;
                  selectedOption = index;
                });
              },
            ),

            const SizedBox(height: 24),

            // ✅ Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex--;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLightBlack,
                      foregroundColor: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios, size: 16),
                        SizedBox(width: 5),
                        Text(
                          "Previous",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                // ✅ Next or Submit Button
                ElevatedButton(
                  onPressed: selectedAnswers[currentIndex] != null
                      ? () {
                          if (currentIndex < questions.length - 1) {
                            setState(() {
                              currentIndex++;
                              selectedOption =
                                  selectedAnswers[currentIndex];
                            });
                          } else {
                            // ✅ Submit Quiz Logic
                            _showSubmitDialog(context);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: AppColors.primaryWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentIndex < questions.length - 1
                            ? "Next"
                            : "Submit",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        currentIndex < questions.length - 1
                            ? Icons.arrow_forward_ios
                            : Icons.check_circle_outline,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ✅ Question Navigator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryGrey),
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryWhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Question Navigator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDeepBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(questions.length, (index) {
                      final isAnswered = selectedAnswers[index] != null;
                      return Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isAnswered
                              ? AppColors.primaryOrange
                              : Colors.transparent,
                          border: Border.all(color: AppColors.primaryGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: isAnswered
                                ? AppColors.primaryWhite
                                : AppColors.primaryDeepBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ✅ Submit confirmation dialog
  void _showSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Submit Quiz?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDeepBlack,
          ),
        ),
        content: const Text(
          "Are you sure you want to submit your answers?",
          style: TextStyle(color: AppColors.primaryDeepBlack),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.primaryLightBlack),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showResultDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: AppColors.primaryWhite,
            ),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  // ✅ Mock result dialog (after submission)
  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Quiz Submitted!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDeepBlack,
          ),
        ),
        content: const Text(
          "Your responses have been recorded successfully.",
          style: TextStyle(color: AppColors.primaryDeepBlack),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              "Close",
              style: TextStyle(color: AppColors.primaryOrange),
            ),
          ),
        ],
      ),
    );
  }
}
