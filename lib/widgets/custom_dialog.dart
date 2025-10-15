import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon; // Optional icon (kept for flexibility)
  final String iconPath; // Path to your asset icon
  final Color iconBgColor;
  final Color iconColor;

  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Color? primaryButtonColor;
  final Color? primaryBorderColor;
  final Color? secondaryButtonColor;
  final Color? secondaryBorderColor;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.iconPath,
    this.icon,
    this.iconBgColor = const Color(0xFFFEF0EA),
    this.iconColor = AppColors.primaryOrange,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.primaryButtonColor,
    this.primaryBorderColor,
    this.secondaryButtonColor,
    this.secondaryBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: AppColors.primaryWhite,
      child: SizedBox(
        width: 330,
        height: 205,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Optional icon
              if (icon != null || iconPath.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ImageIcon(
                    AssetImage(iconPath),
                    size: 53,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // ✅ Title
              CustomText(
                title: title,
                size: 14,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 10),

              // ✅ Message
              Center(
                child: CustomText(
                  title: message,
                  size: 9,
                  color: AppColors.primaryDeepGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (secondaryButtonText != null)
                    _buildDialogButton(
                      context,
                      text: secondaryButtonText!,
                      onPressed:
                          onSecondaryPressed ?? () => Navigator.pop(context),
                      backgroundColor:
                          secondaryButtonColor ?? AppColors.primaryWhite,
                      borderColor:
                          secondaryBorderColor ?? AppColors.primaryGrey,
                      textColor: AppColors.primaryLightBlack,
                    ),
                  if (secondaryButtonText != null) const SizedBox(width: 10),
                  if (primaryButtonText != null)
                    _buildDialogButton(
                      context,
                      text: primaryButtonText!,
                      onPressed:
                          onPrimaryPressed ?? () => Navigator.pop(context),
                      backgroundColor:
                          primaryButtonColor ?? AppColors.primaryOrange,
                      borderColor:
                          primaryBorderColor ?? AppColors.primaryOrange,
                      textColor: AppColors.primaryWhite,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogButton(
    BuildContext context, {
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Center(
          child: CustomText(
            title: text,
            size: 14,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
