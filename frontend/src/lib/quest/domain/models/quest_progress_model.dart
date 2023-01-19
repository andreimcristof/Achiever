class QuestProgress {
  List<DateTime> completedAt;

  QuestProgress({
    this.completedAt = const [],
  });

  bool isCompleted() {
    return completedAt.isNotEmpty;
  }

  void complete() {
    completedAt.add(DateTime.now());
  }
}
