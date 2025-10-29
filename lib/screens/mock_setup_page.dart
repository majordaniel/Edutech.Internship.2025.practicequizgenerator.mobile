import 'dart:io';
import 'package:file_picker/file_picker.dart'
    show FilePicker, FilePickerResult, FileType;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:quiz_generator/api/api.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/helper/helper.dart';
import 'package:quiz_generator/main.dart';
import 'package:quiz_generator/models/quiz.dart';
import 'package:quiz_generator/models/user.dart' show User;
import 'package:quiz_generator/screens/quiz_screen.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

import '../widgets/custom_dialog.dart';
import '../widgets/number_of_questions.dart';
import '../widgets/question_type_selector.dart';

enum QuestionSource {
  fileUpload,
  questionBank;

  @override
  String toString() {
    return switch (this) {
      fileUpload => 'FileUpload',
      questionBank => 'QuestionBank',
    };
  }
}

class QuestionGenerateOptions {
  final courseId =
      'e7a9b6d8-0c2c-4a68-a777-4cd5aa3b68ad'; // Intro to Programming
  final QuestionSource qSource;
  final int timer = 6969;
  final QuestionType qType;
  final int numQuestions;

  QuestionGenerateOptions({
    required this.qType,
    required this.qSource,
    required this.numQuestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'CourseId': courseId,
      'QuestionSource': qSource.toString(),
      'Timer': timer,
      'QuestionType': qType.toString(),
      'NumberOfQuestions': numQuestions,
    };
  }
}

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
  int numberOfQuestions = 16;
  QuestionType selectedType = QuestionType.mcq;
  QuestionType generateFrom = QuestionType.aiGenerated;

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          CustomButton(
                            buttonTitle: "Generate",
                            buttonColor: Colors.deepOrange,
                            textColor: AppColors.primaryWhite,

                            textWeight: FontWeight.w900,
                            textSize: 16,
                            buttonHeight: 50.3,
                            buttonWidth: 90,
                            borderRadius: 12.06,
                            onTap: () async {
                              if (context.mounted) {
                                _generateQuestions(
                                  context,
                                  numberOfQuestions,
                                  selectedType,
                                  generateFrom,
                                );
                              }
                            },
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
                        initialValue: numberOfQuestions,
                        minValue: 6,
                        maxValue: 256,
                        onChanged: (val) {
                          numberOfQuestions = val;
                        },
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
                        groupValue: generateFrom,
                        icon: Image.asset("assets/icons/Vector.png"),
                        onChanged: (value) {
                          setState(() {
                            generateFrom = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      QuestionTypeSelector(
                        title: "Upload Course Material",
                        subtitle:
                            "AI Generate questions from your uploaded materials",
                        value: QuestionType.aiGenerated,
                        groupValue: generateFrom,
                        icon: Image.asset("assets/icons/Group.png"),
                        onChanged: (value) {
                          setState(() => generateFrom = value!);
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

  Future<Quiz> loadQuiz(User user, QuestionGenerateOptions options) async {
    var opts = options.toJson();
    opts['UserId'] = user.id;

    if (options.qSource == QuestionSource.fileUpload) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['txt', 'pdf'],
        type: FileType.custom,
      );
      if (result == null) throw 'Picker exception';
      final file = result.files[0];
      final fpath = file.path!;
      final ext = path.extension(fpath);
      final mime = switch (ext) {
        '.txt' => MediaType('text', 'plain'),
        '.pdf' => MediaType('application', 'pdf'),
        _ => throw 'Internal Error: $ext',
      };

      opts['File'] = await MultipartFile.fromFile(
        fpath,
        filename: file.path,
        contentType: mime,
      );
    }

    final dat = FormData.fromMap(opts);

    // TODO: implement a loading screen for this
    var response = await api.dio.post(
      '/Quiz/generate',
      data: dat,
      queryParameters: Map.fromEntries(dat.fields),
    );

    final data = ApiResponse.fromHttpResponse(
      response.data as Map<String, dynamic>,
    );
    if (data != null && data.succeeded) {
      if (data.data case {
        'quizId': String? quizId,
        'questions': List<dynamic> questions,
      }) {
        var quiz = Quiz.fromList(66, questions);
        return quiz;
      }
    }
    throw 'Invalid form from server: $data';
  }

  Future<dynamic> _generateQuestions(
    BuildContext context,
    int numQuestions,
    QuestionType questionType,
    QuestionType generateFrom,
  ) {
    final genOptions = QuestionGenerateOptions(
      qType: questionType,
      numQuestions: numQuestions,
      qSource: generateFrom == QuestionType.aiGenerated
          ? QuestionSource.fileUpload
          : QuestionSource.questionBank,
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool isLoading = true;
        Quiz? quiz;
        return StatefulBuilder(
          builder: (context, setState) {
            if (quiz == null) {
              print('loading quiz');
              loadQuiz(userController.user, genOptions).then((q) {
                setState(() {
                  quiz = q;
                  isLoading = false;
                });
              });
            }

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

                    onPrimaryPressed: () {
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
