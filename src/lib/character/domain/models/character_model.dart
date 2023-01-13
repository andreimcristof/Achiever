import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:achiever_app/character/domain/models/reward_model.dart';
import 'package:achiever_app/character/domain/models/skill_model.dart';

class Character {
  final String name;
  List<SkillLevel> levels;
  List<Achievement> achievements;
  List<Reward> rewards;

  Character(this.name)
      : levels = <SkillLevel>[],
        achievements = <Achievement>[],
        rewards = <Reward>[];
}
