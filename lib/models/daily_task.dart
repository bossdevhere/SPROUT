import 'package:hive/hive.dart';

part 'daily_task.g.dart';

@HiveType(typeId: 2)
enum TaskCategory {
  @HiveField(0)
  nature,
  @HiveField(1)
  colorHunt,
  @HiveField(2)
  shapeDetective,
  @HiveField(3)
  soundExplorer,
  @HiveField(4)
  movementChallenge,
  @HiveField(5)
  homeHelper,
}

@HiveType(typeId: 3)
enum TaskStatus {
  @HiveField(0)
  locked,
  @HiveField(1)
  active,
  @HiveField(2)
  completed,
}

@HiveType(typeId: 4)
class DailyTask extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  TaskCategory category;

  @HiveField(4)
  int progress;

  @HiveField(5)
  int goal;

  @HiveField(6)
  TaskStatus status;

  @HiveField(7)
  DateTime date;

  @HiveField(8)
  List<String> photoPaths;

  DailyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.progress = 0,
    required this.goal,
    this.status = TaskStatus.locked,
    DateTime? date,
    this.photoPaths = const [],
  }) : date = date ?? DateTime.now();

  DailyTask copyWith({
    String? title,
    String? description,
    TaskCategory? category,
    int? progress,
    int? goal,
    TaskStatus? status,
    DateTime? date,
    List<String>? photoPaths,
  }) {
    return DailyTask(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      progress: progress ?? this.progress,
      goal: goal ?? this.goal,
      status: status ?? this.status,
      date: date ?? this.date,
      photoPaths: photoPaths ?? this.photoPaths,
    );
  }
}
