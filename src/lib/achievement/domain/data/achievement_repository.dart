import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AchievementRepository {
  final String _baseUrl = 'https://example.com/api/items';

  Future<List<Achievement>> fetchItems() async {
    // Make a GET request to the API
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

  Future<http.Response> postItems(List<Achievement> items) async {
    final response = await http.post(
      Uri.https(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(items),
    );
    return response;
  }

  Future<http.Response> postItem(Achievement item) async {
    final response = await http.post(
      Uri.https(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item),
    );
    return response;
  }
}
