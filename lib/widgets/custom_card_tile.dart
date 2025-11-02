import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

class CustomCardTile extends StatelessWidget {
  final String title;
  final String? iconPath; // optional
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showTrailingIcon;
  final double? textSize; // 👈 Added this new field

  const CustomCardTile({
    super.key,
    required this.title,
    this.iconPath,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
    this.showTrailingIcon = true,
    this.textSize, // 👈 Optional, defaults to a reasonable value
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: backgroundColor ?? AppColors.primaryWhite,
        elevation: 4,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // 👇 Show icon only if path is provided
              if (iconPath != null) ...[
                _buildIcon(iconPath!),
                const SizedBox(width: 9.33),
              ],

              // Title Text
              Expanded(
                child: CustomText(
                  title: title,
                  size: textSize ?? 12, // 👈 Use provided or default value
                  color: textColor ?? AppColors.primaryLightBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Optional trailing icon
              if (showTrailingIcon)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: iconColor ?? AppColors.primaryOrange,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for loading either SVG or normal image icons
  Widget _buildIcon(String path) {
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        height: 16,
        width: 16,
        color: iconColor ?? AppColors.primaryOrange,
      );
    } else {
      return ImageIcon(
        AssetImage(path),
        size: 25.0,
        color: iconColor ?? AppColors.primaryOrange,
      );
    }
  }
}
