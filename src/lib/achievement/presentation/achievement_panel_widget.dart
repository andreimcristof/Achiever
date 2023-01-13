import 'package:flutter/material.dart';

class AchievementPanelWidget extends StatelessWidget {
  const AchievementPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: SizedBox(
          width: double.infinity,
          child: Column(children: const [
            Text('Achievements',
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ]),
        ),
      );
    });
  }
}
