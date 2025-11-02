import 'dart:math' show min;

import 'package:quiz_generator/api/api.dart' show Api;
import 'package:quiz_generator/models/quiz.dart';

class QuestionBank {
  DateTime lastUpdate;
  List<Question> _questions;
  final Api _api;

  QuestionBank._(this._questions, this.lastUpdate, this._api);

  factory QuestionBank.init(Api api) {
    return QuestionBank._([], DateTime.timestamp(), api);
  }

  Future<List<Question>> fetchById(String courseId, int maxQuestions) async {
    final newTimestamp = DateTime.timestamp();
    if (_shouldUpdate()) {
      final questions = await _api.fetchQuestionsFromBank(courseId);
      _questions = questions;
      lastUpdate = newTimestamp;
    }
    final n = min(_questions.length, maxQuestions);
    return _questions.take(n).toList(growable: false);
  }

  bool _shouldUpdate() {
    final newTimestamp = DateTime.timestamp();
    // TODO: normally the questions will be cached to a db, since that isn't ready now
    // make the question bank in-memory and only update after (ridiculous) 4 days have passed
    return _questions.isEmpty ||
        newTimestamp.difference(lastUpdate) >= Duration(days: 4);
  }
}
