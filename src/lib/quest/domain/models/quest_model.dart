import 'package:achiever_app/character/domain/models/skill_model.dart';
import 'package:achiever_app/quest/domain/models/quest_difficulty_model.dart';

class Quest {
  final String name;
  final String description;
  final Duration? timebox;
  final Difficulty difficulty;
  DateTime? completedOn;
  final Skill skill;

  Quest(
    this.name,
    this.description,
    this.skill,
    this.difficulty,
    this.timebox,
  );

  int get questPoints {
    return difficultyToPointsMap[difficulty] ?? 0;
  }

  void complete() {
    completedOn = DateTime.now();
  }
}
