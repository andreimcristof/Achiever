import 'dart:async';
import 'package:achiever_app/quest/domain/models/quest_difficulty_model.dart';
import 'package:achiever_app/quest/domain/models/quest_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:duration/duration.dart' as prettyDuration;

class QuestListWidget<T> extends StatefulWidget {
  final T title;
  const QuestListWidget({super.key, required this.title});

  @override
  _RepeatableTaskWidgetState createState() => _RepeatableTaskWidgetState();
} // class QuestListWidget

class _RepeatableTaskWidgetState extends State<QuestListWidget> {
  // Mocked array of Item objects
  final List<Quest> _quests = [
    Quest('Quest 1'),
    Quest('Quest 2'),
    Quest('Quest 3'),
    Quest('Quest 4'),
  ];

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();

    var _createInputController = TextEditingController();
    var _createInputFocusNode = FocusNode();

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        inputFieldSection(_createInputController, _createInputFocusNode),
        const SizedBox(height: 10),
        listSection(audioPlayer),
      ],
    );
  }

  Expanded listSection(AudioPlayer audioPlayer) {
    return Expanded(
      child: ListView.builder(
        itemCount: _quests.length,
        itemBuilder: (BuildContext context, int index) {
          final quest = _quests[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: quest.isCompleted()
                  ? Border.all(color: Colors.green, width: 2)
                  : Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        quest.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: difficultyMap(quest)),
                          Text(
                            'made ${timeago.format(quest.createdAt)} ${quest.hasTimeLimit() ? '| timebox: ${prettyDuration.printDuration(quest.timebox)}' : ''}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                letterSpacing: -.6),
                          ),
                          Row(
                            children: quest.tags
                                .map(
                                  (tag) => Row(children: [
                                    const SizedBox(width: 5),
                                    Chip(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      padding: const EdgeInsets.all(1),
                                      backgroundColor: Colors.grey.shade500,
                                      label: Text(tag,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              letterSpacing: -.5)),
                                    ),
                                  ]),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    quest.isCompleted()
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: quest.isCompleted() ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      quest.complete();
                    });

                    Timer(const Duration(milliseconds: 200), () {
                      audioPlayer
                          .play(DeviceFileSource('assets/sounds/complete.wav'));
                      setState(() {
                        _quests.removeAt(index);
                      });
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> difficultyMap(Quest quest) {
    switch (quest.difficulty) {
      case Difficulty.easy:
        return [
          const Icon(Icons.star, color: Colors.green, size: 15),
          const SizedBox(width: 2),
          const Text(
            'Easy',
            style: TextStyle(color: Colors.green),
          ),
        ];
      case Difficulty.medium:
        return [
          const Icon(Icons.star, color: Colors.orange, size: 15),
          const SizedBox(width: 2),
          const Text(
            'Medium',
            style: TextStyle(color: Colors.orange),
          ),
        ];
      case Difficulty.hard:
        return [
          const Icon(Icons.star, color: Colors.red, size: 15),
          const SizedBox(width: 2),
          const Text(
            'Hard',
            style: TextStyle(color: Colors.red),
          ),
        ];
    }
  }

  AnimatedContainer inputFieldSection(
      TextEditingController _createInputController,
      FocusNode _createInputFocusNode) {
    return AnimatedContainer(
      curve: Curves.bounceIn,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      width: double.infinity,
      duration: const Duration(seconds: 1),
      child: TweenAnimationBuilder<Color?>(
        duration: const Duration(seconds: 3),
        tween: ColorTween(begin: Colors.white, end: Colors.orange),
        builder: (BuildContext context, Color? color, Widget? child) {
          return ColorFiltered(
            colorFilter:
                ColorFilter.mode(color ?? Colors.red, BlendMode.modulate),
            child: TextField(
              controller: _createInputController,
              focusNode: _createInputFocusNode,
              decoration: InputDecoration(
                  hintText: widget.title.toString(),
                  suffixIcon: IconButton(
                      onPressed: _createInputController.clear,
                      icon: const Icon(Icons.clear))),
              onTap: () {},
              onSubmitted: (value) {
                if (value.isEmpty) return;

                setState(() {
                  var quest = Quest(value);
                  _quests.add(quest);
                  _quests.sort(
                      (Quest a, Quest b) => b.createdAt.compareTo(a.createdAt));
                  _createInputFocusNode.requestFocus();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
