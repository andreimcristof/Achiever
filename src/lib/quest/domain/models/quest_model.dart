import 'package:achiever_app/quest/domain/models/quest_difficulty_model.dart';

enum RepeatType { None, Daily, Multiple }

class Quest {
  // mandatory at creation
  final String name;

  // set by ctor automatically
  final DateTime createdAt;

  // adjustable manually later
  Difficulty difficulty;
  RepeatType repeatType;
  String description;
  List<String> tags;
  Duration timebox;
  DateTime? _completedAt;

  Quest(
    this.name, {
    this.difficulty = Difficulty.easy,
    this.repeatType = RepeatType.None,
    this.description = '',
    this.tags = const [],
    this.timebox = Duration.zero,
  }) : createdAt = DateTime.now();

  bool hasTimeLimit() {
    return timebox != Duration.zero;
  }

  int get points {
    return difficultyToPointsMap[difficulty] ?? 0;
  }

  bool isCompleted() {
    return _completedAt != null;
  }

  void complete() {
    _completedAt = DateTime.now();
  }
}
