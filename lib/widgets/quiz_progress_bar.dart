import 'package:flutter/material.dart';
import '../constant/color.dart';

class QuizProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0

  const QuizProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${(progress * 100).round()}% Complete",
          style: const TextStyle(
            color: AppColors.primaryLightBlack,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            color: AppColors.primaryOrange,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
