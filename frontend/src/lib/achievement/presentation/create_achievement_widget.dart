import 'package:achiever_app/achievement/domain/models/achievement_criteria_model.dart';
import 'package:flutter/material.dart';

class CreateAchievementWidget extends StatefulWidget {
  const CreateAchievementWidget({super.key});

  @override
  _CreateAchievementState createState() => _CreateAchievementState();
}

class _CreateAchievementState extends State<CreateAchievementWidget> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late AchievementCriteria _criteria = CompletionAchievementCriteria(10);
  late int _points;
  late String _description;
  late List<String> _tags;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Create Achievement',
              style: Theme.of(context).textTheme.headline6),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) => _name = value!,
          ),
          Column(
            children: <Widget>[
              DropdownButtonFormField<AchievementCriteria>(
                decoration: const InputDecoration(labelText: 'Criteria'),
                value: _criteria,
                items: [
                  DropdownMenuItem(
                    child: const Text('LevelReachAchievementCriteria'),
                    value: LevelReachAchievementCriteria(1),
                  ),
                  DropdownMenuItem(
                    child: const Text('TimeAchievementCriteria'),
                    value: TimedAchievementCriteria(const Duration(minutes: 1)),
                  ),
                  DropdownMenuItem(
                    child: const Text('ComplexAchievementCriteria'),
                    value: CompletionAchievementCriteria(10),
                  ),
                ],
                onChanged: (AchievementCriteria? criteria) {
                  setState(() {
                    _criteria = criteria!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a criteria';
                  }
                  return null;
                },
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Points'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter points';
              }
              return null;
            },
            onSaved: (value) => _points = int.parse(value!),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            onSaved: (value) => _description = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Tags'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter tags';
              }
              return null;
            },
            onSaved: (value) {
              _tags = value!.split(',');
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Create the Achievement entity using the variables _name, _criteria, _points, _description, _tags
                // ...
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
