import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color? buttonColor;
  final Color textColor;
  final FontWeight textWeight;
  final double textSize;
  final double buttonHeight;
  final VoidCallback? onTap;
  final String? iconPath; // 👈 now only supports SVG
  final Color? iconColor;
  final double? borderRadius;
  final Alignment alignment;
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.buttonTitle,
    this.buttonColor,
    required this.textColor,
    required this.textWeight,
    required this.textSize,
    required this.buttonHeight,
    this.onTap,
    this.iconPath,
    this.iconColor,
    this.borderRadius,
    this.alignment = Alignment.center,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: Container(
        width: isFullWidth ? double.infinity : null,
        height: buttonHeight,
        alignment: alignment,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryOrange,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment == Alignment.centerLeft
              ? MainAxisAlignment.start
              : alignment == Alignment.centerRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.center,
          children: [
            // 👇 Show icon only if provided
            if (iconPath != null) ...[
              _buildIcon(iconPath!),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: CustomText(
                title: buttonTitle,
                size: textSize,
                color: textColor,
                fontWeight: textWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Helper widget for SVG icons
  Widget _buildIcon(String path) {
    return SvgPicture.asset(
      path,
      height: 20,
      width: 20,
      colorFilter: iconColor != null
          ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
          : null,
    );
  }
}
