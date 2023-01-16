import 'package:achiever_app/quest/domain/models/quest_difficulty_model.dart';

class Quest {
  final String name;
  final Difficulty difficulty;
  final String? description;
  final Duration? timebox;
  final List<String> tags;
  DateTime? completedOn;
  DateTime createdAt;

  Quest(
    this.name,
    this.difficulty,
    this.tags,
  )   : description = 'null',
        timebox = null,
        createdAt = DateTime.now();

  int get questPoints {
    return difficultyToPointsMap[difficulty] ?? 0;
  }

  void complete() {
    completedOn = DateTime.now();
  }

  bool isCompleted() {
    return completedOn != null;
  }
}
