import 'package:achiever_app/achievement/presentation/achievement_list_widget.dart';
import 'package:achiever_app/achievement/presentation/achievement_panel_widget.dart';
import 'package:achiever_app/quest/presentation/quest_list.dart';
import 'package:achiever_app/quest/presentation/quest_panel_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  final bool showQuests;

  const DashboardWidget({Key? key, required this.showQuests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (showQuests)
          Expanded(
            child: Container(
              color: Colors.green,
              child: const Center(
                child: QuestPanelWidget(),
              ),
            ),
          ),
        if (!showQuests)
          Expanded(
            child: Container(
              color: Colors.green,
              child: const Center(
                child: AchievementPanelWidget(),
              ),
            ),
          ),
      ],
    );
  }
}
