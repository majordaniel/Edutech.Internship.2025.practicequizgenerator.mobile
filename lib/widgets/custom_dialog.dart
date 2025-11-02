import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        padding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG Icon
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: icon != null
                  ? Icon(icon, size: 30, color: AppColors.primaryOrange)
                  : SvgPicture.asset(
                      iconPath,
                      height: 30,
                      width: 30,
                      color: AppColors.primaryOrange,
                    ),
            ),
            SizedBox(height: 13),

            // Title
            Center(
              child: CustomText(
                title: title,
                size: 16,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // Message
            Center(
              child: CustomText(
                title: message,
                size: 10,
                color: AppColors.primaryLightBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Buttons Row
            Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                if (secondaryButtonText != null)
                  IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: secondaryBorderColor ??
                                AppColors.primaryOrange),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CustomButton(
                        buttonTitle: secondaryButtonText!,
                        onTap: onSecondaryPressed ?? () {},
                        textColor: AppColors.primaryOrange,
                        buttonColor: Colors.transparent,
                        buttonHeight: 40,
                        borderRadius: 3,
                        textWeight: FontWeight.w600,
                        textSize: 12.6,
                        isFullWidth: false, // ✅ Add this flag in your button
                      ),
                    ),
                  ),

                if (primaryButtonText != null)
                  IntrinsicWidth(
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
                      isFullWidth: false, // ✅ Add this flag too
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
