class AchievementProgress {
  late final int stepsRequired;
  late int stepsCompleted;
  DateTime? completedAt;

  AchievementProgress({this.stepsRequired = 1})
      : stepsCompleted = 0,
        completedAt = null;

  AchievementProgress.fromJson(Map<String, dynamic> json) {
    stepsRequired = json['stepsRequired'];
    stepsCompleted = json['stepsCompleted'];
    completedAt = json['completedAt'];
  }

  void addProgress() {
    stepsCompleted++;
    if (stepsRequired == stepsCompleted) {
      completedAt = DateTime.now();
    }
  }
}
