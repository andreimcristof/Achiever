import 'package:achiever_app/achievement/domain/models/achievement_model.dart';
import 'package:achiever_app/achievement/domain/services/achievement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementListWidget extends StatelessWidget {
  const AchievementListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = Provider.of<AchievementProvider>(context).fetchItems();
    return StreamBuilder<List<Achievement>>(
        stream: stream.asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].name);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
