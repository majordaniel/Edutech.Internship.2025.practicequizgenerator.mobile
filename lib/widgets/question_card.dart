import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'option_tile.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int> onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnswered = selectedIndex != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAnswered ? AppColors.primaryOrange : AppColors.primaryGrey,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.primaryDeepBlack,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(options.length, (index) {
            return OptionTile(
              text: options[index],
              isSelected: selectedIndex == index,
              onTap: () => onOptionSelected(index),
            );
          }),
        ],
      ),
    );
  }
}
