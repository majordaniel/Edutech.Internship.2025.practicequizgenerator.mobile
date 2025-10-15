import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String questionNumber;
  final String questionText;
  final List<String> options;
  final int? selectedOptionIndex;
  final Function(int)? onOptionSelected;
  final bool isAnswered;

  // ✅ Customizable colors
  final Color answeredColor;
  final Color unansweredColor;
  final Color borderColor;
  final Color questionTextColor;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.options,
    this.selectedOptionIndex,
    this.onOptionSelected,
    this.isAnswered = false,
    this.answeredColor = const Color(0xFFE8F5E9), // light green
    this.unansweredColor = const Color(0xFFF9F9F9), // light grey
    this.borderColor = const Color(0xFFDDDDDD),
    this.questionTextColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAnswered ? answeredColor : unansweredColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            children: [
              Text(
                'Question $questionNumber',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isAnswered ? Colors.green[100] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isAnswered ? 'Answered' : 'Unanswered',
                  style: TextStyle(
                    fontSize: 12,
                    color: isAnswered ? Colors.green[800] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            questionText,
            style: TextStyle(
              fontSize: 14,
              color: questionTextColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // Options List
          Column(
            children: List.generate(
              options.length,
              (index) {
                final isSelected = selectedOptionIndex == index;
                return GestureDetector(
                  onTap: onOptionSelected != null
                      ? () => onOptionSelected!(index)
                      : null,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? Colors.orange
                            : const Color(0xFFE0E0E0),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected ? Colors.orange : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isSelected ? Colors.orange[900] : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
