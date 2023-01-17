import 'package:achiever_app/achievement/presentation/achievement_list_widget.dart';
import 'package:flutter/material.dart';

class AchievementPanelWidget extends StatelessWidget {
  const AchievementPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(children: const [
              SizedBox(height: 10),
              Expanded(
                child: AchievementListWidget(),
              )
            ]),
          ),
        ),
      );
    });
  }
}
