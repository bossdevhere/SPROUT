import 'package:hive_flutter/hive_flutter.dart';
import 'package:sprout/models/character_customization.dart';
import 'package:sprout/models/daily_task.dart';
import 'package:sprout/models/user_progress.dart';

class StorageService {
  static const String _userBoxName = 'user_box';
  static const String _tasksBoxName = 'tasks_box';
  static const String _customizationBoxName = 'customization_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register Adapters
    Hive.registerAdapter(CharacterCustomizationAdapter());
    Hive.registerAdapter(UserProgressAdapter());
    Hive.registerAdapter(TaskCategoryAdapter());
    Hive.registerAdapter(TaskStatusAdapter());
    Hive.registerAdapter(DailyTaskAdapter());

    // Open Boxes
    await Hive.openBox<UserProgress>(_userBoxName);
    await Hive.openBox<DailyTask>(_tasksBoxName);
    await Hive.openBox<CharacterCustomization>(_customizationBoxName);
  }

  // User Progress
  static Box<UserProgress> getUserBox() => Hive.box<UserProgress>(_userBoxName);
  
  static UserProgress getUserProgress() {
    final box = getUserBox();
    return box.get('current_user') ?? UserProgress();
  }

  static Future<void> saveUserProgress(UserProgress progress) async {
    await getUserBox().put('current_user', progress);
  }

  // Character Customization
  static Box<CharacterCustomization> getCustomizationBox() => 
      Hive.box<CharacterCustomization>(_customizationBoxName);

  static CharacterCustomization getCustomization() {
    final box = getCustomizationBox();
    return box.get('current_customization') ?? CharacterCustomization();
  }

  static Future<void> saveCustomization(CharacterCustomization customization) async {
    await getCustomizationBox().put('current_customization', customization);
  }

  // Daily Tasks
  static Box<DailyTask> getTasksBox() => Hive.box<DailyTask>(_tasksBoxName);

  static List<DailyTask> getTasks() {
    return getTasksBox().values.toList();
  }

  static Future<void> saveTask(DailyTask task) async {
    await getTasksBox().put(task.id, task);
  }

  static Future<void> saveTasks(List<DailyTask> tasks) async {
    final box = getTasksBox();
    for (final task in tasks) {
      await box.put(task.id, task);
    }
  }

  static Future<void> clearOldTasks() async {
    await getTasksBox().clear();
  }
}
