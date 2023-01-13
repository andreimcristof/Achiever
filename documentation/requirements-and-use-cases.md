# Defining Requirements

- I can create, read, update, delete ACH (Achievement)
- An ACH can be standalone, or Epic ACH
- An ACH can be:
  - Completion ACH (X out of Y)
  - Challenge ACH (Timed)
  - Exploration ACH (get acquainted with field X)
- I can see my ACH Board at any time, shows progress
  per each achievement.
- I can interact and tick an ACH to complete it
- An ACH could have a reward (Title?)

## Use Cases

- Create Read Update Delete Achievements
- See Board of Achievements with Summary
- Interact with Achievements to complete them

## Tech Stack

### Decisional Factors for choosing Tech Stack

- how do we use the app? desktop/mobile/web?
- multiple devices must be supported from start?
- familiar already with any languages/frameworks?
- speed of development important?
  - finish it quick, or
  - take time to learn smth new?
- cloud services requirements?
  - should it store anything in cloud?

### Answers

- the app needs to be immediately accessible on user desktop while working on other tasks. Perhaps a desktop app living in systray
- learning new things is prioritized over speed of development
- desktop app that can be easily ported to web / mobile
- experience background is in C#, TS, Java, so any of those is fine. But Dart has several advantages over these:

#### Picking Dart/Flutter? Advantages

- cross-platform desktop/mobile/web
  - one codebase to rule all platforms
  - very easy to just reuse codebase for a diff platform, with one line build command.
- fun language to learn
- Flutter supports a local DB w/ SQLite
- excellent docus
- design consistency (Material UI)

### Decision

- Desktop app
- Flutter framework with Dart
- local database only for simplicity of first version
