import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color? buttonColor;
  final Color textColor;
  final FontWeight textWeight;
  final double? buttonWidth;
  final double textSize;
  final double buttonHeight;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Image? image;
  final Alignment alignment; // added field

  const CustomButton({
    super.key,
    required this.buttonTitle,
    this.buttonColor,
    required this.textColor,
    required this.textWeight,
    required this.textSize,
    required this.buttonHeight,
    this.buttonWidth,
    this.onTap,
    this.borderRadius,
    this.image,
    this.alignment = Alignment.center, // default value for optional param
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        alignment: alignment, // use it here
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryOrange,
          borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment == Alignment.centerLeft
              ? MainAxisAlignment.start
              : alignment == Alignment.centerRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.center,
          children: [
            if (image != null) ...[image!, const SizedBox(width: 8)],
            CustomText(
              title: buttonTitle,
              size: textSize,
              color: textColor,
              fontWeight: textWeight,
            ),
          ],
        ),
      ),
    );
  }
}
