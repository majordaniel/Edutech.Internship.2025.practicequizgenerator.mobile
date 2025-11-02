import 'package:flutter/material.dart';

import '../constant/color.dart';
import 'custom_text.dart';

class CompactNumberSpinner extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int>? onChanged;

  const CompactNumberSpinner({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 99,
    this.onChanged,
  });

  @override
  State<CompactNumberSpinner> createState() => _CompactNumberSpinnerState();
}

class _CompactNumberSpinnerState extends State<CompactNumberSpinner> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void _increment() {
    if (value < widget.maxValue) {
      setState(() => value++);
      widget.onChanged?.call(value);
    }
  }

  void _decrement() {
    if (value > widget.minValue) {
      setState(() => value--);
      widget.onChanged?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Number text
            CustomText(
              title: value.toString().padLeft(2, '0'),
              size: 16,
              color: AppColors.primaryLightBlack,
              fontWeight: FontWeight.w400,
            ),
      
            // Vertical arrows column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _increment,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 24,
                    color: AppColors.primaryLightBlack,
                  ),
                ),
                GestureDetector(
                  onTap: _decrement,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppColors.primaryLightBlack,
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
