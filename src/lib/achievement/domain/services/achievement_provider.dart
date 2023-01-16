import 'package:achiever_app/achievement/domain/data/achievement_repository.dart';
import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:flutter/material.dart';

class AchievementProvider with ChangeNotifier {
  List<Achievement> _achievements = [];
  final repository = MockAchievementRepository();

  List<Achievement> get achievements => _achievements;

  Future<Achievement> addItem(
      Achievement<AchievementCriteria> achievement) async {
    final item = await repository.addItem(achievement);

    _achievements.add(item);
    notifyListeners();
    return achievement;
  }

  Future<List<Achievement>> fetchItems() async {
    final achievements = await repository.fetchItems();
    _achievements = achievements;
    notifyListeners();
    return _achievements;
  }
}
