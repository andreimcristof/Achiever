import 'package:flutter/material.dart';

class CharacterWidget extends StatefulWidget {
  const CharacterWidget({super.key});

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context)
                .copyWith(
                  canvasColor: Colors.transparent,
                )
                .primaryColor,
            child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.start,
                            children: [
                          Icon(Icons.person_outline,
                              size: 50, color: Colors.white),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Character Name, level, etc.',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ]))
                  ],
                )),
          ),
        )
      ],
    );
  }
}
