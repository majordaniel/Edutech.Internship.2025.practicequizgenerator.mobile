import 'dart:math' show min;

import 'package:quiz_generator/api/api.dart' show Api;
import 'package:quiz_generator/models/quiz.dart';

class QuestionBank {
  // TODO: store this by the courseId
  DateTime lastUpdate;
  Map<String, List<Question>> _qMap;
  final Api _api;

  QuestionBank._(this._qMap, this.lastUpdate, this._api);

  factory QuestionBank.init(Api api) {
    return QuestionBank._({}, DateTime.timestamp(), api);
  }

  Future<List<Question>?> fetchById(String courseId, int maxQuestions) async {
    final newTimestamp = DateTime.timestamp();
    if (_shouldUpdate()) {
      final questions = await _api.fetchQuestionsFromBank(courseId);
      lastUpdate = newTimestamp;
      _qMap[courseId] = questions;
    }
    if (_qMap.containsKey(courseId)) {
      final q = _qMap[courseId]!;
      final n = min(q.length, maxQuestions);
      return q.take(n).toList(growable: false);
    }
    return null;
  }

  bool _shouldUpdate() {
    final newTimestamp = DateTime.timestamp();
    // TODO: normally the questions will be cached to a db, since that isn't ready now
    // make the question bank in-memory and only update after (ridiculous) 4 days have passed
    return _qMap.isEmpty ||
        newTimestamp.difference(lastUpdate) >= Duration(days: 4);
  }
}
