class TagLevel {
  late final String tag;
  late final int level;

  TagLevel(this.tag, this.level);

  TagLevel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    level = json['level'];
  }
}
