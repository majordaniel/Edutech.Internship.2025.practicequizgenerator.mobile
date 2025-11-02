import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

class CustomCardTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomCardTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: backgroundColor ?? AppColors.primaryWhite,
        elevation: 2,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(iconPath),
                size: 25.0,
                color: iconColor ?? AppColors.primaryOrange,
              ),
              const SizedBox(width: 16.0),
              CustomText(
                title: title,
                size: 12,
                color: textColor ?? AppColors.primaryLightBlack,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
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
}
