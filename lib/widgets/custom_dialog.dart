import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomDialog extends StatelessWidget {
  final IconData? icon;
  final String iconPath;
  final String title;
  final String message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final Color? primaryButtonColor;
  final Color? primaryBorderColor;
  final Color? secondaryBorderColor;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  // ✅ New fields for layout control
  final EdgeInsetsGeometry? contentPadding;
  final MainAxisAlignment? buttonAlignment;

  const CustomDialog({
    super.key,
    this.icon,
    required this.iconPath,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.primaryButtonColor,
    this.primaryBorderColor,
    this.secondaryBorderColor,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.contentPadding,
    this.buttonAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Padding(
        // ✅ Use dynamic content padding
        padding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            if (icon != null)
              Icon(icon, size: 50, color: AppColors.primaryOrange)
            else
              Image.asset(iconPath, height: 50, width: 50, fit: BoxFit.contain),
            const SizedBox(height: 16),

            // Title
            CustomText(
              title: title,
              size: 16,
              color: AppColors.primaryDeepBlack,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 8),

            // Message
            CustomText(
              title: message,
              size: 13,
              color: AppColors.primaryLightBlack,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment:
                  buttonAlignment ?? MainAxisAlignment.end, // ✅ New alignment
              children: [
                if (secondaryButtonText != null)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: (AppColors.primaryOrange)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: CustomButton(
                        buttonTitle: secondaryButtonText!,
                        onTap: onSecondaryPressed ?? () {},

                        textColor: AppColors.primaryOrange,
                        buttonColor: Colors.transparent,
                        buttonHeight: 40,
                        // borderRadius: 3,
                        textWeight: FontWeight.w600,
                        textSize: 12.6,
                      ),
                    ),
                  ),
                if (secondaryButtonText != null && primaryButtonText != null)
                  const SizedBox(width: 17),
                if (primaryButtonText != null)
                  Expanded(
                    child: CustomButton(
                      buttonTitle: primaryButtonText!,
                      onTap: onPrimaryPressed ?? () {},

                      buttonColor:
                          primaryButtonColor ?? AppColors.primaryOrange,
                      textColor: AppColors.primaryWhite,
                      buttonHeight: 40,
                      borderRadius: 3,
                      textWeight: FontWeight.w600,
                      textSize: 12.6,
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
