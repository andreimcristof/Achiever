import 'package:achiever_app/quest/presentation/quest_list.dart';
import 'package:flutter/material.dart';

class QuestPanelWidget extends StatelessWidget {
  const QuestPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: questListBoxDecoration(),
                child: const QuestListWidget(
                  title: 'New Habit - Repeat multiple times',
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: questListBoxDecoration(),
                child: const QuestListWidget(
                    title: 'New Daily - Repeat once daily'),
              ),
            ),
            Expanded(
              child: Container(
                decoration: questListBoxDecoration(),
                child: const QuestListWidget(
                  title: 'New Errand - Complete once',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  BoxDecoration questListBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(
        color: Colors.grey.shade400,
        width: 1,
      ),
    );
  }
}
