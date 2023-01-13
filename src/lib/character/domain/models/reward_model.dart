class Reward {
  DateTime? acquiredOn;

  Reward();

  acquire() {
    acquiredOn = DateTime.now();
  }
}

class Title extends Reward {
  final String name;
  final String description;

  Title(this.name, this.description) : super();
}
