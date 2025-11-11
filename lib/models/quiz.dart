class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const Question(
    this.id, {
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    final opts =
        (map['options'] as List?)?.map((e) => e.toString()).toList() ?? [];
    return Question(
      map['id']?.toString() ?? 'unknown',
      question:
          map['text']?.toString() ??
          map['questionText']?.toString() ??
          'No question',
      options: opts,
      correctOptionIndex: map['correctOptionIndex'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln(question)
      ..writeln();

    for (int i = 0; i < options.length; i++) {
      buffer.writeln('${i + 1}. ${options[i]}');
    }

    if (correctOptionIndex >= 0 && correctOptionIndex < options.length) {
      buffer.writeln(
        '\nCorrect option: ${correctOptionIndex + 1}. ${options[correctOptionIndex]}',
      );
    } else {
      buffer.writeln('\nNo correct option specified');
    }
    return buffer.toString();
  }
}

class Quiz {
  final int id;
  final String courseTitle;
  final List<Question> questions;

  int get length => questions.length;

  const Quiz({
    required this.id,
    required this.courseTitle,
    required this.questions,
  });

  factory Quiz.fromList({
    required int id,
    required String courseTitle,
    required List<dynamic> questionsList,
  }) {
    final List<Question> parsedQuestions = [];

    for (final dynamic data in questionsList) {
      if (data is! Map<String, dynamic>) {
        print('Warning: Skipping invalid question format');
        continue;
      }

      try {
        final String questionText =
            data['questionText']?.toString() ??
            data['text']?.toString() ??
            'No question text';

        final List<dynamic>? rawOptions = data['options'] as List<dynamic>?;
        if (rawOptions == null || rawOptions.isEmpty) {
          print('Warning: Question has no options, skipping');
          continue;
        }

        final List<String> options = rawOptions.map((opt) {
          if (opt is Map<String, dynamic>) {
            return opt['text']?.toString() ??
                opt['optionText']?.toString() ??
                'No option text';
          }
          return opt.toString();
        }).toList();

        if (options.isEmpty) {
          print('Warning: Question has empty options, skipping');
          continue;
        }

        var correctOptionIndex = 0;
        if (data['correctOptionIndex'] is int) {
          correctOptionIndex = data['correctOptionIndex'] as int;
        } else if (data['correctAnswer'] != null) {
          final correctAnswer = data['correctAnswer'].toString();
          final idx = options.indexWhere(
            (opt) => opt.toLowerCase() == correctAnswer.toLowerCase(),
          );
          correctOptionIndex = idx != -1 ? idx : 0;
        }

        if (correctOptionIndex >= options.length) {
          correctOptionIndex = 0;
        }

        parsedQuestions.add(
          Question(
            data['id']?.toString() ?? 'generated-id-${parsedQuestions.length}',
            question: questionText,
            options: options,
            correctOptionIndex: correctOptionIndex,
          ),
        );
      } catch (e) {
        print('Warning: Error parsing question: $e');
        continue;
      }
    }

    if (parsedQuestions.isEmpty) {
      throw ArgumentError('No valid questions could be parsed from the data');
    }

    return Quiz(id: id, courseTitle: courseTitle, questions: parsedQuestions);
  }

  @override
  String toString() {
    var tos = StringBuffer();
    tos.writeln('quiz id: $id');
    for (final q in questions) {
      tos.writeln('$q\n--------');
    }
    return tos.toString();
  }
}

extension GetFail on Map<String, dynamic> {
  T getFail<T>(String k) {
    if (containsKey(k)) {
      final value = this[k];
      if (value is T) {
        return value;
      }
      throw ArgumentError('Map/getFail: Value for "$k" is not of type $T');
    }
    throw ArgumentError('Map/getFail: Key "$k" not found');
  }
}
