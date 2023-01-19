import 'package:achiever_app/achievement/domain/models/achievement_criteria_model.dart';
import 'package:achiever_app/achievement/domain/models/achievement_progress_model.dart';

class Achievement<T extends AchievementCriteria> {
  // mandatory at creation
  late final String name;
  late final T achievementCriteria;
  late final int points;
  late AchievementProgress progress;

  // changeable later
  late String description;
  late List<String> tags;

  Achievement(
    this.name,
    this.achievementCriteria, {
    this.description = '',
    this.points = achievementMinPoints,
  })  : tags = [],
        progress = AchievementProgress();

  Achievement.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    points = json['points'];
    tags = json['tags'].cast<String>();
    progress = AchievementProgress.fromJson(json['progress']);
  }

  void addProgress() {
    progress.addProgress();
  }
}

const int achievementMinPoints = 10;
