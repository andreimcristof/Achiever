import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:achiever_app/character/domain/models/reward_model.dart';
import 'package:achiever_app/character/domain/models/tag_level_model.dart';

class Character {
  late final String name;
  late List<TagLevel> levels;
  late List<Achievement> achievements;
  late List<Reward> rewards;

  Character(this.name)
      : levels = <TagLevel>[],
        achievements = <Achievement>[],
        rewards = <Reward>[];

  Character.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    levels = json['levels'].map((e) => TagLevel.fromJson(e)).toList();
    achievements =
        json['achievements'].map((e) => Achievement.fromJson(e)).toList();
    rewards = json['rewards'].map((e) => Reward.fromJson(e)).toList();
  }
}
