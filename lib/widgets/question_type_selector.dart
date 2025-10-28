import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

enum QuestionType {
  mcq,
  theory,
  mixed,
  pastQuestions,
  aiGenerated;

  @override
  String toString() {
    return switch (this) {
      mcq => 'MCQ',
      theory => 'Theory',
      mixed => 'Mixed',
      pastQuestions => 'Past Questions',
      aiGenerated => 'AI Generated',
    };
  }
}

class QuestionTypeSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final QuestionType value;
  final QuestionType groupValue;
  final ValueChanged<QuestionType?> onChanged;
  final Widget? icon; // optional static icon

  const QuestionTypeSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryOrange
                : AppColors.primaryGrey.withOpacity(0.6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Radio with tighter spacing
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Radio<QuestionType>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: AppColors.primaryOrange,
                visualDensity:
                    VisualDensity.compact, // makes it tighter vertically too
              ),
            ),

            // Optional static icon close to the radio
            if (icon != null) ...[
              Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                ), // close but clean spacing
                child: icon!,
              ),
            ],

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    size: 12,
                    color: AppColors.primaryLightBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    title: subtitle,
                    size: 10,
                    color: AppColors.primaryDeepGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
