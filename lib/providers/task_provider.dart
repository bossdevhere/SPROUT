import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sprout/models/daily_task.dart';
import 'package:sprout/services/storage_service.dart';

class TaskProvider extends ChangeNotifier {
  List<DailyTask> _tasks = [];
  
  TaskProvider() {
    _loadTasks();
  }

  void _loadTasks() {
    _tasks = StorageService.getTasks();
    
    // Check if we need to generate new tasks for today
    if (_tasks.isEmpty || !_isSameDay(_tasks.first.date, DateTime.now())) {
      generateDailyTasks();
    }
    notifyListeners();
  }

  List<DailyTask> get tasks => _tasks;
  
  int get completedTasksCount => _tasks.where((t) => t.status == TaskStatus.completed).length;
  bool get allTasksCompleted => _tasks.isNotEmpty && completedTasksCount == _tasks.length;

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  Future<void> generateDailyTasks() async {
    await StorageService.clearOldTasks();
    
    final random = Random();
    final List<DailyTask> pool = _getTaskPool();
    final List<DailyTask> selected = [];
    
    // Pick 3 random tasks from different categories if possible
    final List<TaskCategory> categories = TaskCategory.values.toList()..shuffle();
    
    for (int i = 0; i < 3; i++) {
      final category = categories[i % categories.length];
      final categoryTasks = pool.where((t) => t.category == category).toList();
      
      if (categoryTasks.isNotEmpty) {
        final task = categoryTasks[random.nextInt(categoryTasks.length)];
        selected.add(task.copyWith(date: DateTime.now(), status: TaskStatus.active));
      }
    }

    _tasks = selected;
    await StorageService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTaskProgress(String taskId, int progress, {Function(int)? onReward}) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      if (task.status == TaskStatus.completed) return;

      final newProgress = min(task.goal, task.progress + progress);
      final isNowCompleted = newProgress >= task.goal;
      final newStatus = isNowCompleted ? TaskStatus.completed : task.status;
      
      _tasks[index] = task.copyWith(progress: newProgress, status: newStatus);
      await StorageService.saveTask(_tasks[index]);
      
      if (isNowCompleted && onReward != null) {
        onReward(10); // Normal task reward
        if (allTasksCompleted) {
          onReward(50); // Bonus reward
        }
      }
      
      notifyListeners();
    }
  }

  List<DailyTask> _getTaskPool() {
    return [
      // Nature Explorer
      DailyTask(id: 'n1', title: 'Find 3 flowers', description: 'Look for beautiful flowers and take photos of them!', category: TaskCategory.nature, goal: 3),
      DailyTask(id: 'n2', title: 'Find a butterfly', description: 'Can you spot a flying friend?', category: TaskCategory.nature, goal: 1),
      DailyTask(id: 'n3', title: 'Find a tree', description: 'Look for a big, tall tree!', category: TaskCategory.nature, goal: 1),
      DailyTask(id: 'n4', title: 'Find 2 leaves', description: 'Find two different types of leaves!', category: TaskCategory.nature, goal: 2),
      
      // Color Hunt
      DailyTask(id: 'c1', title: 'Find 3 red objects', description: 'Search for things that are red!', category: TaskCategory.colorHunt, goal: 3),
      DailyTask(id: 'c2', title: 'Find 2 blue objects', description: 'Can you find something blue?', category: TaskCategory.colorHunt, goal: 2),
      DailyTask(id: 'c3', title: 'Find a yellow object', description: 'Look for something bright like the sun!', category: TaskCategory.colorHunt, goal: 1),
      DailyTask(id: 'c4', title: 'Find a green object', description: 'Find something green like grass!', category: TaskCategory.colorHunt, goal: 1),
      
      // Shape Detective
      DailyTask(id: 's1', title: 'Find 3 circles', description: 'Look for things that are round!', category: TaskCategory.shapeDetective, goal: 3),
      DailyTask(id: 's2', title: 'Find 2 squares', description: 'Search for things with four sides!', category: TaskCategory.shapeDetective, goal: 2),
      DailyTask(id: 's3', title: 'Find a triangle', description: 'Can you find a shape with 3 points?', category: TaskCategory.shapeDetective, goal: 1),
      
      // Movement Challenge
      DailyTask(id: 'm1', title: 'Jump 10 times', description: 'Jump as high as you can!', category: TaskCategory.movementChallenge, goal: 10),
      DailyTask(id: 'm2', title: 'Dance for 30 seconds', description: 'Show us your best dance moves!', category: TaskCategory.movementChallenge, goal: 1),
      DailyTask(id: 'm3', title: 'Spin 5 times', description: 'Twirl around like a top!', category: TaskCategory.movementChallenge, goal: 5),
      
      // Home Helper
      DailyTask(id: 'h1', title: 'Water a plant', description: 'Help a plant friend get a drink!', category: TaskCategory.homeHelper, goal: 1),
      DailyTask(id: 'h2', title: 'Put away 3 toys', description: 'Help clean up your play area!', category: TaskCategory.homeHelper, goal: 3),
      DailyTask(id: 'h3', title: 'Arrange books', description: 'Make your bookshelf look neat!', category: TaskCategory.homeHelper, goal: 1),
    ];
  }
}
