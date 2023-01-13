import 'package:flutter/material.dart';

class DashboardContainerWidget extends StatelessWidget {
  const DashboardContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: SizedBox(
          width: double.infinity,
          child: Column(children: const [
            Text('Quests or Achievements selection changes stuff here',
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ]),
        ),
      );
    });
  }
}
