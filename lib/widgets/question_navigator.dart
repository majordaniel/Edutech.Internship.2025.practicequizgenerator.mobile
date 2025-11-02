import 'package:flutter/material.dart';
import '../constant/color.dart';

class QuestionNavigator extends StatelessWidget {
  final int total;
  final int currentIndex;
  final ValueChanged<int> onSelect;

  const QuestionNavigator({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.generate(total, (index) {
        final isCurrent = currentIndex == index;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppColors.primaryOrange
                  : AppColors.primaryWhite,
              border: Border.all(color: AppColors.primaryGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: isCurrent
                    ? AppColors.primaryWhite
                    : AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}
