import 'package:achiever_app/achievement/presentation/create_achievement_widget.dart';
import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum MenuItem { achievements, character, quests }

class AppMenuWidget extends StatefulWidget {
  const AppMenuWidget({super.key});

  @override
  State<AppMenuWidget> createState() => _AppMenuExampleState();
}

class _AppMenuExampleState extends State<AppMenuWidget> {
  MenuItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: const [
            Icon(Icons.menu),
            SizedBox(width: 10),
            Text('Menu'),
          ],
        ),
      ),
      onSelected: (MenuItem item) {
        if (item == MenuItem.achievements) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: const Text('Achievements')),
                body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: CreateAchievementWidget(),
                        )
                      ]),
                ),
              ),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.achievements,
          child: Text('Manage Achievements'),
        ),
        const PopupMenuItem<MenuItem>(
          value: MenuItem.character,
          child: Text('Manage Character'),
        ),
        const PopupMenuItem<MenuItem>(
          value: MenuItem.quests,
          child: Text('Manage Quests'),
        ),
      ],
    );
  }
}
