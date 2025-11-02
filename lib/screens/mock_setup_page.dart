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
import 'package:quiz_generator/models/course.dart';
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
  final String courseId;
  final QuestionSource qSource;
  final int timer = 6969;
  final QuestionType qType;
  final int numQuestions;

  QuestionGenerateOptions({
    required this.courseId,
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
  int seconds = 0, minutes = 5;
  String? selectCourseId;
  int numberOfQuestions = 16;
  QuestionType selectedType = QuestionType.mcq;
  QuestionType generateFrom = QuestionType.aiGenerated;
  Future<List<Course>> courses = Future.value([]);

  @override
  void initState() {
    super.initState();
    // try to fetch the courses before loading the screen
    courses = userController.courses();
  }

  Future<String?> _courseTitle(String courseId) async {
    for (final course in await courses) {
      if (course.id == courseId) {
        return course.title;
      }
    }
    return null;
  }

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
                              if (selectCourseId != null && context.mounted) {
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
                      FutureBuilder(
                        future: courses,
                        initialData: [Course('4444', title: 'A Darned Course')],
                        builder: (context, asyncSnapshot) {
                          var dropdownItems = <DropdownMenuItem>[];

                          if (asyncSnapshot.connectionState ==
                              ConnectionState.done) {
                            print(
                              'FutureBuilder/dropdown: ${asyncSnapshot.data}',
                            );

                            if (asyncSnapshot.data == null) {
                              print(
                                'FutureBuilder/dropdown: error: ${asyncSnapshot.error}',
                              );
                            } else {
                              dropdownItems = asyncSnapshot.data!
                                  .map(
                                    (course) => DropdownMenuItem(
                                      value: course.title,
                                      child: CustomText(
                                        title: course.title,
                                        size: 16,
                                        color: AppColors.primaryDeepBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                  .toList(growable: false);
                            }
                          }

                          return DropdownButtonFormField(
                            dropdownColor: AppColors.primaryWhite,
                            // initialValue: selectCourseId,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: dropdownItems,
                            onChanged: (course) async {
                              for (final c in (await courses)) {
                                if (c.title == course) {
                                  setState(() {
                                    print(
                                      'course changed to "$course:${c.id}"',
                                    );
                                    selectCourseId = c.id;
                                  });
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Choose a course from your program',
                              hintStyle: Helper.hintStyle,
                              border: Helper.decoration,
                              focusedBorder: Helper.decoration,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          );
                        },
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

  Future<Quiz?> loadQuizFromQuestionBank(
    String courseId,
    QuestionGenerateOptions opts,
  ) async {
    print('LoadQuizFromQuestionBank: to load for "$courseId');
    try {
      final questions = await questionBank.fetchById(
        courseId,
        opts.numQuestions,
      );
      if (questions == null) {
        print(
          'LoadQuizFromQuestionBank/error: $courseId does not have questions here',
        );
        return null;
      }
      print('loaded $questions from question bank');

      final courseTitle = await _courseTitle(courseId);
      return Quiz.fromQuestions(4444, courseTitle!, questions);
    } on Object catch (e) {
      print('LoadQuizFromQuestionBank/error: $e');
      rethrow;
    }
  }

  Future<Quiz?> loadQuizFromFileUpload(
    User user,
    String courseId,
    QuestionGenerateOptions options,
  ) async {
    var opts = options.toJson();
    opts['UserId'] = user.id;

    if (options.qSource == QuestionSource.fileUpload) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['txt', 'pdf'],
        type: FileType.custom,
      );
      if (result == null) return null;
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
        final courseTitle = await _courseTitle(courseId);
        var quiz = Quiz.fromList(66, courseTitle!, questions);
        return quiz;
      }
    }
    throw 'Invalid form from server: $data';
  }

  Future<Quiz?> _loadQuiz(User user, QuestionGenerateOptions options) async {
    try {
      if (options.qSource == QuestionSource.questionBank) {
        return await loadQuizFromQuestionBank(selectCourseId!, options);
      }

      return await loadQuizFromFileUpload(user, selectCourseId!, options);
    } on Object catch (e) {
      print('Load quiz error: $e');
      return null;
    }
  }

  Future<dynamic> _generateQuestions(
    BuildContext context,
    int numQuestions,
    QuestionType questionType,
    QuestionType generateFrom,
  ) {
    final genOptions = QuestionGenerateOptions(
      courseId: selectCourseId!,
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
        return FutureBuilder(
          future: _loadQuiz(userController.user, genOptions),
          builder: (context, AsyncSnapshot asyncSnapshot) {
            return StatefulBuilder(
              builder: (context, setState) {
                if (asyncSnapshot.connectionState == ConnectionState.done) {
                  final data = asyncSnapshot.data as Quiz?;
                  print('FutureBuilder.data = $data');

                  setState(() {
                    isLoading = false;
                    quiz = data;
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
                          if (quiz is Quiz && mounted) {
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
      },
    );
  }
}
