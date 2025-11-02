class Question {
  final String id;
  final int correctIdx;
  List<String> options;
  String question;
  Question(
    this.id, {
    required this.question,
    required this.options,
    required this.correctIdx,
  });

  @override
  String toString() {
    var tos = StringBuffer();
    tos.writeln('$question\n');
    for (int i = 0; i < options.length; i += 1) {
      tos.writeln('${i + 1}. ${options[i]}');
    }
    tos.writeln('\nCorrect option: $correctIdx. ${options[correctIdx]}');

    return tos.toString();
  }
}

class Quiz {
  final int id;
  List<Question> questions;
  int get length => questions.length;

  Quiz._(this.id, this.questions);

  factory Quiz.fromQuestions(int id, List<Question> questions) {
    return Quiz._(id, questions);
  }

  factory Quiz.fromList(int id, List<dynamic> questions) {
    List<Question> qs = [];
    for (Map<String, dynamic> quizMap in questions) {
      if (quizMap case {
        'questionText': String question,
        'correctOptionIndex': int correctOptionIndex,
        'options': List opts,
      }) {
        var options = List.castFrom<dynamic, Map<String, dynamic>>(
          opts,
        ).map((o) => o['text'] as String).toList();
        qs.add(
          Question(
            'fake-question-id',
            question: question,
            options: options,
            correctIdx: correctOptionIndex,
          ),
        );
      } else {
        throw 'Invalid quiz map shape: $quizMap';
      }
    }

    return Quiz._(id, qs);
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
  dynamic getFail(String k) {
    if (containsKey(k)) {
      return this[k];
    } else {
      throw 'Map/getFail: "$k" not found';
    }
  }
}
