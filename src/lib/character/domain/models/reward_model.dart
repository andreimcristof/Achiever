class Reward {
  DateTime? completedAt;

  complete() {
    completedAt = DateTime.now();
  }

  Reward();

  Reward.fromJson(Map<String, dynamic> json) {
    completedAt = json['completedAt'];
  }
}

class Title extends Reward {
  final String name;
  final String description;

  Title(this.name, this.description) : super();

  Title.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        super.fromJson(json);
}
