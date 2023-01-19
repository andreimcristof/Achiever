# Database specs

- we use DynamoDB which requires specific planning in advance:
  - composite primary key
  - pre-planning queries in advance
  - designing a single-table solution for multiple entities, through PK strategy

**_NOTE:_** For now, multiple user support will not be implemented. The Achiever app assumes only one user for simplicity. Should we add multiuser support, our primary key for DynamoDB would drastically change.

## Entities as grouped information

- We group information together so that when we make a query for e.g. a single entity such as an Achievement, we get all its related data such as progress etc. This allows us to store multiple entities in one table, so that we can query by separate entities without having to implement costly solutions such as indexes.

- Our Partition key and Sort key are just called that: PK and SK, not anything entity related, so that we don't reason about the table as belonging to a single entity.

- Below are the entities decided for now. For example Achievement and AchievementProgress share the same Partition Key, so that when you query by that partition key you get both. But you can still get a more specific result, if you include the sort key in the query.
- This is the way I thought of designign tables for lowest cost in DynamoDB - grouping entities together. Read about this strategy in Alex DeBrie's blogs and videos. He is a specialist in DynamoDB and has excellent documentation about how to design for low-cost and max efficiency.
- Mistakes will be made during the various iterations. Things might not be optimal in the entities because I prioritize getting the app done. If you have ideas for improvement, [reach out to me](https://andreicristof.com/)

### Achievement

- PK: `ACHIEVEMENT#<achName>`
- SK: `ACHIEVEMENT#<achName>`
- Attributes:
  - `name`
  - `criteria`
  - `points`
  - `description`

### AchievementProgress

- PK: `ACHIEVEMENT#<achName>`
- SK: `ACHIEVEMENTPROGRESS`
- Attributes:
  - `completedAt`
  - `stepsRequired`
  - `stepsCompleted`

### Quest

- PK: `QUEST#<questName>`
- SK: `QUEST#<questName>`
- Attributes:
  - `createdAt`
  - `difficulty`
  - `repeatType`
  - `description`
  - `tags`
  - `timebox`

### QuestProgress

- PK: `QUEST#<questName>`
- SK: `QUESTPROGRESS`
- Attributes:
  - `completedAt`

### Character

- PK: `CHARACTER#<name>`
- SK: `CHARACTER#<name>`
- Attributes:
  - `levels`
  - `achievements`
  - `rewards`
