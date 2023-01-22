import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/achievement_criteria_model.dart';

abstract class BaseAchievementRepository {
  Future<List<Achievement>> fetchItems();
  Future<Achievement> addItem(Achievement item);
}

class MockAchievementRepository extends BaseAchievementRepository {
  final List<Achievement> _mockData = [
    Achievement<CompletionAchievementCriteria>(
        'completion1', CompletionAchievementCriteria(5),
        points: 20),
    Achievement<LevelReachAchievementCriteria>(
        'lvlreach1', LevelReachAchievementCriteria(10),
        points: 30)
  ];

  @override
  Future<List<Achievement>> fetchItems() async {
    return _mockData;
  }

  @override
  Future<Achievement> addItem(Achievement item) async {
    _mockData.add(item);
    return item;
  }
}

class AchievementRepository extends BaseAchievementRepository {
  final String _baseUrl = 'https://example.com/api/items';

  @override
  Future<List<Achievement>> fetchItems() async {
    final response = await http.get(
      Uri.https(_baseUrl),
    );

    if (response.statusCode == 200) {
      final achievementsJson = json.decode(response.body) as List;
      return achievementsJson
          .map((itemJson) => Achievement.fromJson(itemJson))
          .toList();
    } else {
      throw Exception('Failed to fetch items');
    }
  }

  @override
  Future<Achievement> addItem(Achievement item) async {
    final response = await http.post(
      Uri.https(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item),
    );
    if (response.statusCode == 200) {
      return item;
    } else {
      throw Exception('Failed to add item');
    }
  }
}
