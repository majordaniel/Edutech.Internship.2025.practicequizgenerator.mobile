import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:dio/dio.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/helper/helper.dart';
import 'package:quiz_generator/main.dart';
import 'package:quiz_generator/models/quiz.dart';
import 'package:quiz_generator/screens/quiz_screen.dart';
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
    'Computer Science',
    'Discrete Mathematics',
    'Linear Algebra',
    'Information Technology',
    'Algorithm Design',
  ];

  int seconds = 0, minutes = 5;
  String? selectedValue;
  QuestionType selectedType = QuestionType.mcq;

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
                              Navigator.pop(context);
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
                              _showDialogFn(context);
                            },
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            title: "Computer Science",
                            size: 14,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        title: "Select Course",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        dropdownColor: AppColors.primaryWhite,
                        initialValue: selectedValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
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
                      const SizedBox(height: 16),

                      CustomText(
                        title: "Question Type",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Multiple Choice Questions",
                        subtitle: "Quick Selection questions",
                        value: QuestionType.mcq,
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
                        value: QuestionType.theory,
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
                        value: QuestionType.mixed,
                        groupValue: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomText(
                        title: "Number of Questions",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),

                      CompactNumberSpinner(
                        initialValue: 0,
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        title: "Minimum 5, Maximum 50 questions",
                        size: 10,
                        color: AppColors.primaryDeepGrey,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),

                      CustomText(
                        title: "Timer",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 120,
                            child: CompactNumberSpinner(
                              initialValue: minutes,
                              minValue: 2,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  minutes = val;
                                });
                              },
                            ),
                          ),
                          CustomText(
                            title: "Minutes",
                            size: 11,
                            color: AppColors.primaryDeepBlack,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            width: 120,
                            child: CompactNumberSpinner(
                              initialValue: seconds,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  seconds = val;
                                });
                              },
                            ),
                          ),
                          CustomText(
                            title: "Seconds",
                            size: 11,
                            color: AppColors.primaryDeepBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      CustomText(
                        title: "Generate from:",
                        size: 14,
                        color: AppColors.primaryDeepBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "From Past Exams",
                        subtitle:
                            "Generate Questions from Question Bank database",
                        value: QuestionType.pastQuestions,
                        groupValue: selectedType,
                        icon: Image.asset("assets/icons/Vector.png"),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Upload Course Material",
                        subtitle:
                            "AI Generate questions from your uploaded materials",
                        value: QuestionType.aiGenerated,
                        groupValue: selectedType,
                        icon: Image.asset("assets/icons/Group.png"),
                        onChanged: (value) {
                          setState(() => selectedType = value!);
                        },
                      ),
                      const SizedBox(height: 15),
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

  Future<Quiz> loadQuiz() async {
    var baseDirectory = await platformApi.baseDirectory();
    var t = File('${baseDirectory.path}/Documents/timeout.txt');
    print('$t exists: ${t.existsSync()}');
    var n = t.lengthSync();

    final baseOptions = BaseOptions(
      baseUrl: api.baseUrl.toString(),
      headers: {'X-API-Key': api.key},
    );
    final dio = Dio(baseOptions);

    var dat = FormData.fromMap({
      'QuestionType': 'Multiple Choice Question',
      'NumberOfQuestions': 44.toString(),
      'File': await MultipartFile.fromFile(t.path, filename: 'upload.txt'),
    });

    // TODO: implement a loading screen for this
    var response = await dio.post(
      '/Quiz/generatefromfile',
      data: dat,
      queryParameters: Map.fromEntries(dat.fields),
    );

    var data = response.data['data'] as Map<String, Object?>;
    if (data case {
      'qizId': int? quizId,
      'questions': List<dynamic> questions,
    }) {
      var quiz = Quiz.fromList(quizId ?? 0, questions);
      // print(quiz);
      return quiz;
    } else {
      throw 'Invalid form from server';
    }
  }

  Future<dynamic> _showDialogFn(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool isLoading = true;
        Quiz? quiz;
        return StatefulBuilder(
          builder: (context, setState) {
            loadQuiz().then((q) {
              setState(() {
                quiz = q;
                isLoading = false;
              });
            });

            return isLoading
                ? const CustomDialog(
                    icon: Icons.hourglass_empty,
                    iconPath: 'assets/icons/Edit Square.png',
                    title: "Generating Mock Exam Questions",
                    message: "Loading.........",
                  )
                : CustomDialog(
                    icon: Icons.check_circle_outline,
                    iconPath: 'assets/icons/Edit Square.png',
                    title: "Mock Quiz Successfully Configured",
                    message: "Your Quiz Starts in 09:00 sec",
                    secondaryButtonText: "Review Selections",
                    primaryButtonText: "Start Quiz",
                    primaryButtonColor: AppColors.primaryOrange,
                    primaryBorderColor: AppColors.primaryOrange,
                    secondaryBorderColor: AppColors.primaryOrange,
                    // ✅ Add consistent padding inside the dialog
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    // ✅ Properly align buttons at the bottom with spacing
                    buttonAlignment: MainAxisAlignment.spaceBetween,
                    onSecondaryPressed: () {
                      Navigator.pop(context);
                    },

                    onPrimaryPressed: () async {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return QuizScreen(
                                quiz: quiz!,
                                duration: Duration(
                                  minutes: minutes,
                                  seconds: seconds,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
          },
        );
      },
    );
  }
}
