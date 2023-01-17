class AchievementCriteria {}

class LevelReachAchievementCriteria extends AchievementCriteria {
  final int levelRequired;
  LevelReachAchievementCriteria(this.levelRequired);

  LevelReachAchievementCriteria.fromJson(Map<String, dynamic> json)
      : levelRequired = json['levelRequired'];
}

class TimedAchievementCriteria extends AchievementCriteria {
  final Duration timeRequired;
  TimedAchievementCriteria(this.timeRequired);

  TimedAchievementCriteria.fromJson(Map<String, dynamic> json)
      : timeRequired = Duration(seconds: json['timeRequired']);
}

class CompletionAchievementCriteria extends AchievementCriteria {
  final int completionCountRequired;
  CompletionAchievementCriteria(this.completionCountRequired);

  CompletionAchievementCriteria.fromJson(Map<String, dynamic> json)
      : completionCountRequired = json['completionCountRequired'];
}
