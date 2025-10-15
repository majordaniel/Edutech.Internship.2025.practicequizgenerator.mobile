import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/helper/helper.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

import '../widgets/custom_dialog.dart';
import '../widgets/number_of_questions.dart';
import '../widgets/question_type_selector.dart';

class MockSetupPage extends StatefulWidget {
  const MockSetupPage({super.key});

  @override
  State<MockSetupPage> createState() => _MockSetupPageState();
}

class _MockSetupPageState extends State<MockSetupPage> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? selectedValue;
  String selectedType = 'mcq';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Back Arrow Button
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.primaryDeepBlack,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              ); // Go back to the previous screen
                            },
                          ),
                          const SizedBox(width: 5),

                          const Spacer(),
                          Icon(
                            Icons.notifications_none,
                            color: AppColors.primaryBlack,
                            size: 24.0,
                          ),
                        ],
                      ),
                      CustomText(
                        title: "Set up Mock Exam",
                        size: 20,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomButton(
                            buttonTitle: "Program",
                            textColor: AppColors.primaryWhite,
                            textWeight: FontWeight.w500,
                            textSize: 12.6,
                            buttonHeight: 21.3,
                            buttonWidth: 73.9,
                            borderRadius: 12.06,
                            onTap: () async {
                              // Show first dialog
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const CustomDialog(
                                  icon: Icons.check_circle_outline,
                                  title: "Generating Mock Exam Questions",
                                  message: "Loading.........",
                                  iconPath: 'assets/icons/Edit Square.png',
                                ),
                              );

                              // Wait 2 seconds safely
                              await Future.delayed(const Duration(seconds: 2));

                              // ✅ Check if widget is still mounted before using context
                              if (!mounted) return;

                              // Close the first dialog
                              Navigator.pop(context);

                              // ✅ Show second dialog safely
                              if (!mounted) return;

                              showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                  icon: Icons.check_circle_outline,
                                  iconPath: 'assets/icons/Success.png',
                                  title: "Mock Quiz Successfully Configured",
                                  message:
                                      "Your mock quiz has been successfully set up. You can review your selections or start the quiz now.",
                                  secondaryButtonText: "Review Selections",
                                  primaryButtonText: "Start Quiz",
                                  primaryButtonColor: AppColors.primaryOrange,
                                  primaryBorderColor: AppColors.primaryOrange,
                                  secondaryBorderColor: AppColors.primaryOrange,
                                  onSecondaryPressed: () {
                                    Navigator.pop(context);
                                    // Navigate to review screen or stay on this page
                                  },
                                  onPrimaryPressed: () {
                                    Navigator.pop(context);
                                    // Navigate to the quiz page
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            title: "Computer Science",
                            size: 14,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        title: "Select Course",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                        dropdownColor: AppColors.primaryWhite,
                        initialValue: selectedValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items
                            .map(
                              (method) => DropdownMenuItem(
                                value: method,
                                child: CustomText(
                                  title: method,
                                  size: 16,
                                  color: AppColors.primaryDeepBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Choose a course from your program',
                          hintStyle: Helper.hintStyle,
                          border: Helper.decoration,
                          focusedBorder: Helper.decoration,
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(height: 16),
                      CustomText(
                        title: "Question Type",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Multiple Choice Questions",
                        subtitle: "Quick Selection questions",
                        value: "mcq",
                        groupValue: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Theory",
                        subtitle: "Written explanation",
                        value: "t",
                        groupValue: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Mixed",
                        subtitle: "Both Types Combined",
                        value: "m",
                        groupValue: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CustomText(
                        title: "Number of Questions",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      CompactNumberSpinner(
                        initialValue: 0,
                        onChanged: (val) {},
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        title: "Minimum 5, Maximum 50 questions",
                        size: 10,
                        color: AppColors.primaryDeepGrey,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        title: "Timer",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      CompactNumberSpinner(
                        initialValue: 0,
                        onChanged: (val) {},
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        title: "30 minutes to 2 hours",
                        size: 10,
                        color: AppColors.primaryDeepGrey,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "From Past Exams",
                        subtitle:
                            "Generate Questions from Question Bank database",
                        value: "fpe",
                        groupValue: selectedType,
                        icon: Image.asset("assets/icons/Vector.png"),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Upload Course Material",
                        subtitle:
                            "AI Generate questions from your uploaded materials",
                        value: "upm",
                        groupValue: selectedType,
                        icon: Image.asset("assets/icons/Group.png"),
                        onChanged: (value) {
                          setState(() => selectedType = value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
