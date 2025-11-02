import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final Color iconBgColor;
  final Color iconColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
    this.iconBgColor = const Color(0xFFFEF0EA),
    this.iconColor = AppColors.primaryOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        color: AppColors.primaryWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                size: 14,
                color: AppColors.primaryLightBlack,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: value,
                    size: 20,
                    color: AppColors.primaryDeepBlack,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: iconBgColor,
                    ),
                    child: ImageIcon(AssetImage(iconPath), color: iconColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
