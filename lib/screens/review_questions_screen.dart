import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../widgets/question_card.dart';

class ReviewQuestionsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final List<int?> selectedAnswers;
  final bool showAnswered;

  const ReviewQuestionsScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.showAnswered,
  });

  @override
  State<ReviewQuestionsScreen> createState() => _ReviewQuestionsScreenState();
}

class _ReviewQuestionsScreenState extends State<ReviewQuestionsScreen> {
  late List<int?> selectedAnswers;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.from(widget.selectedAnswers);
  }

  @override
  Widget build(BuildContext context) {
    final filteredQuestions = List.generate(widget.questions.length, (i) => i)
        .where((i) => widget.showAnswered
            ? selectedAnswers[i] != null
            : selectedAnswers[i] == null)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Text(
          widget.showAnswered ? "Answered Questions" : "Unanswered Questions",
          style: const TextStyle(
            color: AppColors.primaryDeepBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: filteredQuestions.isEmpty
          ? const Center(
              child: Text(
                "No questions in this category.",
                style: TextStyle(color: AppColors.primaryDeepBlack),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredQuestions.length,
              itemBuilder: (context, index) {
                final qIndex = filteredQuestions[index];
                final question = widget.questions[qIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: QuestionCard(
                    question: question['question'],
                    options: List<String>.from(question['options']),
                    selectedIndex: selectedAnswers[qIndex],
                    onOptionSelected: (optIndex) {
                      setState(() {
                        selectedAnswers[qIndex] = optIndex;
                      });
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedAnswers);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            foregroundColor: AppColors.primaryWhite,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Submit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
