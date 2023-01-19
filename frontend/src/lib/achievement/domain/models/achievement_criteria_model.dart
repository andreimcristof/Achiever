class AchievementCriteria {}

class LevelReachAchievementCriteria extends AchievementCriteria {
  final int levelRequired;
  LevelReachAchievementCriteria(this.levelRequired);

  LevelReachAchievementCriteria.fromJson(Map<String, dynamic> json)
      : levelRequired = json['levelRequired'];

  bool operator ==(dynamic other) =>
      other != null &&
      other is LevelReachAchievementCriteria &&
      this.levelRequired == other.levelRequired;

  @override
  int get hashCode => super.hashCode;
}

class TimedAchievementCriteria extends AchievementCriteria {
  final Duration timeRequired;
  TimedAchievementCriteria(this.timeRequired);

  TimedAchievementCriteria.fromJson(Map<String, dynamic> json)
      : timeRequired = Duration(seconds: json['timeRequired']);

  bool operator ==(dynamic other) =>
      other != null &&
      other is TimedAchievementCriteria &&
      this.timeRequired == other.timeRequired;

  @override
  int get hashCode => super.hashCode;
}

class CompletionAchievementCriteria extends AchievementCriteria {
  final int completionCountRequired;
  CompletionAchievementCriteria(this.completionCountRequired);

  CompletionAchievementCriteria.fromJson(Map<String, dynamic> json)
      : completionCountRequired = json['completionCountRequired'];

  bool operator ==(dynamic other) =>
      other != null &&
      other is CompletionAchievementCriteria &&
      this.completionCountRequired == other.completionCountRequired;

  @override
  int get hashCode => super.hashCode;
}
