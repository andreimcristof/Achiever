import 'package:achiever_app/achievement/domain/data/achievement_repository.dart';
import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:flutter/material.dart';

class AchievementService extends StatefulWidget {
  const AchievementService({super.key});

  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<AchievementService> {
  final _repository = AchievementRepository();
  List<Achievement> _achievements = [];

  @override
  void initState() {
    super.initState();

    _fetchItems();
  }

  Future<void> _fetchItems() async {
    try {
      final achievements = await _repository.fetchItems();

      setState(() {
        _achievements = achievements;
      });
    } catch (e) {
      _showErrorMessage();
    }
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to load achievements'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _achievements.isNotEmpty ? _buildAchievements() : _buildLoading();
  }

  _buildAchievements() => ListView.builder(
      itemBuilder: ((context, index) {
        final achievement = _achievements[index];
        return ListTile(
          title: Text(achievement.name),
          subtitle: Text(achievement.description),
          // trailing: Text(achievement.achievementCriteria.toString()),
        );
      }),
      itemCount: _achievements.length);

  _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
