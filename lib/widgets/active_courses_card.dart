import 'package:flutter/material.dart';
import '../constant/color.dart';
import '../widgets/custom_text.dart';

class ActiveCoursesCard extends StatelessWidget {
  final List<String> activeCourses = [
    "Flutter Development",
    "UI/UX Design Fundamentals",
    "Backend with Node.js",
    "Introduction to Cybersecurity",
  ];

  ActiveCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: AppColors.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // keep uniform card padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Use ListView.separated to add spacing only between items
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeCourses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 21), // gap between items
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: activeCourses[index],
                    size: 10,
                    color: AppColors.primaryLightBlack,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
