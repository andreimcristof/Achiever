# Entities

## Achievement

```dart
- Name              string
- Description       string
- PointsRequired    int
- State             [NotDone, Done]
- Type              [Challenge, Completion, Exploration, Reach]
- Skill             string (skill name)
```

## Quest

```dart
- Name              string
- Description       string
- Timebox           Duration, optional
- Difficulty        [Low(2pts), Med(4pts), High(6pts)]
- State             [NotDone, Done]
- Skill             string (skill name)
```

## Skill

```dart
- Name
- ParentSkill       optional
```

## Level

```dart
- Current           int
- Progress          class LevelProgress(current_points int, required_points int)
```

## Character

```dart
- Name              string
- Level             Level
- Achievements      List<IAchievement>
- Rewards           List<IReward>

- levelUp()         {
                      lvl++;
                      lvl_pts += lvl * prev_lvl_pts * 0.12;
                    }

- progressUp(points int)      {
                       level.progress.current_points += points;
                    }
```

## Additional Considerations

### Quests and Achievements

- The Quests I complete count towards achievements.
  - But a Quest cannot be linked 1:1 with an Ach at Quest creation time, since even if I create an Ach AFTER I created a Quest, that Quest must STILL count towards the newly created Ach. Hence, a different, independent link between Quests and Achievements is needed.
- Therefore, to link the Quest and Ach we create the entity: Skill.

  - a Quest always adds to a Skill, once its complete (you learn something out of every action, it mirrors real life)
  - a Skill has a ParentSkill property which is optional. When its NULL, it means the Skill is a base skill. Examples of skills:
    - Skill:
      - CarDriving
        - Parent: NULL
      - CarParking
        - Parent: CarDriving

- What are Points?

  - Each Quest has a difficulty. Low, Med, High. They give different points.
  - Setting a Quest.Status to Status.Done means that Skill got an extra amount of points (defined by the Quest difficulty).

- What are Levels?
  - a Level is a sense of progression, that makes us complete Quests. Having a level that we can see visually and a progress bar showing how much it has left until the next level, makes the whole system more engaging, more enticing and more interesting.
  - Levels are advanced with points of the Skills of the character.
