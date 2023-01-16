import 'package:achiever_app/achievement/domain/services/achievement_provider.dart';
import 'package:achiever_app/character/presentation/character_widget.dart';
import 'package:achiever_app/dashboard/presentation/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AchievementProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

const appTitle = 'Achiever';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Open Sans',
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showQuests = true;

  void changePanel(bool showQuests) {
    setState(() {
      _showQuests = showQuests;
    });
  }

  @override
  Widget build(BuildContext context) {
    const actionStyle = TextStyle(fontSize: 20, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // state altering actions
          // https://api.flutter.dev/flutter/material/TextButton-class.html#material.TextButton.2

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: actionStyle,
              ),
              onPressed: (() => changePanel(true)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.list_alt),
                  const SizedBox(
                    width: 10,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 10),
                    child: const Text(
                      'Quests',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: actionStyle,
            ),
            onPressed: (() => changePanel(false)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rate_outlined),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Achievements',
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
          ),
        ],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CharacterWidget(),
            Expanded(
              child: DashboardWidget(showQuests: _showQuests),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
