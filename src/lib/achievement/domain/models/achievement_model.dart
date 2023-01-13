/// Achievement model class that accepts a generic type of AchievementCriteria
class Achievement<T extends AchievementCriteria> {
  final String name;
  final String description;
  DateTime? acquiredOn;

  T achievementCriteria;

  Achievement(this.name, this.description, this.achievementCriteria);

  void complete() {
    acquiredOn = DateTime.now();
  }
}

/// each Achievement subtype has different completion criteria.
/// This serves as base class for all completion criteria.
class AchievementCriteria {}

class LevelReachAchievementCriteria extends AchievementCriteria {
  final int levelRequired;
  LevelReachAchievementCriteria(this.levelRequired);
}

class TimedAchievementCriteria extends AchievementCriteria {
  final Duration timeRequired;
  TimedAchievementCriteria(this.timeRequired);
}

class CompletionAchievementCriteria extends AchievementCriteria {
  final int completionCountRequired;
  CompletionAchievementCriteria(this.completionCountRequired);
}

// usage:

var levelReachedAchievement = Achievement<LevelReachAchievementCriteria>(
    'name', 'description', LevelReachAchievementCriteria(10));

var timedAchievement = Achievement<TimedAchievementCriteria>('name',
    'description', TimedAchievementCriteria(const Duration(seconds: 60)));

var completionAchievement = Achievement<CompletionAchievementCriteria>(
    'name', 'description', CompletionAchievementCriteria(10));
