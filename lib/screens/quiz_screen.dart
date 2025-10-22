import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_generator/models/quiz.dart' show Quiz;
import 'package:quiz_generator/screens/mock_setup_page.dart';
import '../constant/color.dart';
import '../widgets/quiz_progress_bar.dart';
import '../widgets/question_card.dart';

final List<Map<String, dynamic>> _questions = [
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

class QuizScreen extends StatefulWidget {
  final Duration duration;
  final Quiz quiz;
  const QuizScreen({super.key, required this.duration, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedOption;
  late List<int?> selectedAnswers;
  late Duration remainingTime;
  late Timer timer;
  late final Quiz quiz;

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    selectedAnswers = List<int?>.filled(quiz.questions.length, null);
    remainingTime = widget.duration;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == widget.duration.inSeconds) {
        // time up!
        print('time up!');
        t.cancel();
      }
      setState(() {
        remainingTime = Duration(
          seconds: widget.duration.inSeconds - t.tick,
          // 1 /* to account for zero start of t.tick */,
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final question = quiz.questions[currentIndex];
    final rs = remainingTime.inSeconds % 60,
        remSeconds = rs < 10 ? '0$rs' : rs,
        rm = remainingTime.inMinutes,
        remMinutes = rm < 10 ? '0$rm' : rm;

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: AppColors.primaryDeepBlack),
                SizedBox(width: 6),
                Text(
                  '$remMinutes:$remSeconds',
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
            QuizProgressBar(progress: (currentIndex + 1) / quiz.length),
            const SizedBox(height: 24),

            Text(
              "Question ${currentIndex + 1}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.primaryDeepBlack,
              ),
            ),
            const SizedBox(height: 10),

            QuestionCard(
              question: question.question,
              options: List<String>.from(question.options),
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
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios_new, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Prev",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: AppColors.primaryWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),

                  onPressed: selectedAnswers[currentIndex] != null
                      ? () {
                          if (currentIndex < quiz.length - 1) {
                            setState(() {
                              currentIndex++;
                              selectedOption = selectedAnswers[currentIndex];
                            });
                          } else {
                            final answeredCount = selectedAnswers
                                .where((a) => a != null)
                                .length;
                            final unansweredCount = quiz.length - answeredCount;
                            _showSubmitDialog(
                              context,
                              answeredCount,
                              unansweredCount,
                            );
                          }
                        }
                      : null,

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentIndex < quiz.length - 1 ? "Next" : "Submit",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        currentIndex < quiz.length - 1
                            ? Icons.arrow_forward_ios
                            : Icons.check_circle_outline,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ Responsive Question Navigator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryGrey),
                borderRadius: BorderRadius.circular(10),
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
                    children: List.generate(quiz.length, (index) {
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
                          borderRadius: BorderRadius.circular(6),
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
          ],
        ),
      ),
    );
  }

  // ✅ Responsive Submit Dialog
  void _showSubmitDialog(BuildContext context, int answered, int unanswered) {
    final answered = selectedAnswers.where((a) => a != null).length;
    final unanswered = quiz.length - answered;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔶 Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE9D6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFFFF7A00),
                  size: 40,
                ),
              ),
              const SizedBox(height: 12),

              // 📝 Title
              const Text(
                "Confirm Submission",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2E2E2E),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Answered Questions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Answered Questions: $answered",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFF7A00)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      // TODO: Jump to answered questions screen
                    },
                    child: const Text(
                      "Review Question",
                      style: TextStyle(
                        color: Color(0xFFFF7A00),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ❌ Unanswered Questions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Unanswered Questions: $unanswered",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFF7A00)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      // TODO: Jump to unanswered questions screen
                    },
                    child: const Text(
                      "Review Question",
                      style: TextStyle(
                        color: Color(0xFFFF7A00),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 🟧 Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showResultDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Quiz Submitted!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E2E2E),
          ),
        ),
        content: const Text(
          "Your responses have been recorded successfully.",
          style: TextStyle(color: Color(0xFF2E2E2E)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                ctx,
                MaterialPageRoute(builder: (context) => MockSetupPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7A00),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              "Close",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
