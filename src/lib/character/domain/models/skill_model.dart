/// Skill Model that can optionally have a parent skill
class Skill {
  final String name;
  final Skill? parentSkill;

  Skill(this.name, {this.parentSkill});
}

class SkillLevel {
  final Skill skill;
  final int level;

  SkillLevel(this.skill, this.level);
}
