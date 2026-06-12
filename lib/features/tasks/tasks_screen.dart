import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:sprout/models/daily_task.dart';
import 'package:sprout/providers/task_provider.dart';
import 'package:sprout/providers/user_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:sprout/features/camera/camera_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _showCelebration = false;

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;

    if (taskProvider.allTasksCompleted && !_showCelebration) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          setState(() {
            _showCelebration = true;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Adventures', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProgressHeader(taskProvider),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return _buildTaskCard(context, tasks[index]);
                    },
                  ),
                ),
                if (taskProvider.allTasksCompleted)
                  _buildCompletionMessage(),
              ],
            ),
          ),
          if (_showCelebration)
            _buildCelebrationOverlay(),
        ],
      ),
    );
  }

  Widget _buildCelebrationOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/80236a6a-2f63-4414-874f-958564a91942/n69UjH0wN6.json',
              height: 300,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.celebration_rounded,
                color: AppColors.starGold,
                size: 100,
              ),
            ),
            const Text(
              'YOU DID IT!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ).animate().scale(duration: 500.ms, curve: Curves.elasticOut).shimmer(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => _showCelebration = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              ),
              child: const Text('YAY!'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildProgressHeader(TaskProvider taskProvider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${taskProvider.completedTasksCount}/3 Tasks Done',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.star_rounded, color: AppColors.starGold, size: 28),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: taskProvider.tasks.isEmpty ? 0 : taskProvider.completedTasksCount / taskProvider.tasks.length,
          backgroundColor: Colors.black12,
          color: AppColors.success,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, DailyTask task) {
    final isCompleted = task.status == TaskStatus.completed;
    final categoryColor = _getCategoryColor(task.category);

    return Card(
      elevation: isCompleted ? 0 : 2,
      color: isCompleted ? Colors.black.withValues(alpha: 0.05) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: isCompleted 
            ? BorderSide.none 
            : BorderSide(color: categoryColor.withValues(alpha: 0.3), width: 2),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: categoryColor.withValues(alpha: 0.2),
          child: Icon(_getCategoryIcon(task.category), color: categoryColor),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : AppColors.darkText,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: task.progress / task.goal,
                      backgroundColor: Colors.black12,
                      color: categoryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text('${task.progress}/${task.goal}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        trailing: isCompleted 
            ? const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 32)
            : IconButton(
                onPressed: () => _handleTaskTap(context, task),
                icon: const Icon(Icons.camera_alt_rounded, color: AppColors.softPurple, size: 32),
              ),
      ),
    );
  }

  Widget _buildCompletionMessage() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: AppColors.warmYellow.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.starGold, width: 2),
      ),
      child: const Column(
        children: [
          Text(
            '🌟 Amazing Job! 🌟',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          SizedBox(height: 8),
          Text(
            'You completed all your adventures for today! Come back tomorrow for more!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _handleTaskTap(BuildContext context, DailyTask task) async {
    final taskProvider = context.read<TaskProvider>();
    final userProvider = context.read<UserProvider>();

    if (task.category != TaskCategory.movementChallenge) {
      final String? photoPath = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(taskTitle: task.title),
        ),
      );

      if (photoPath != null && context.mounted) {
        await taskProvider.updateTaskProgress(
          task.id,
          1,
          onReward: (amount) {
            userProvider.addStars(amount);
            if (amount == 50) {
              userProvider.completeTasks();
            }
          },
        );
      }
    } else {
      await taskProvider.updateTaskProgress(
        task.id,
        task.goal,
        onReward: (amount) {
          userProvider.addStars(amount);
          if (amount == 50) {
            userProvider.completeTasks();
          }
        },
      );
    }
  }

  Color _getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.nature: return AppColors.nature;
      case TaskCategory.colorHunt: return AppColors.colorHunt;
      case TaskCategory.shapeDetective: return AppColors.shapeDetective;
      case TaskCategory.soundExplorer: return AppColors.soundExplorer;
      case TaskCategory.movementChallenge: return AppColors.movementChallenge;
      case TaskCategory.homeHelper: return AppColors.homeHelper;
    }
  }

  IconData _getCategoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.nature: return Icons.forest_rounded;
      case TaskCategory.colorHunt: return Icons.color_lens_rounded;
      case TaskCategory.shapeDetective: return Icons.category_rounded;
      case TaskCategory.soundExplorer: return Icons.mic_rounded;
      case TaskCategory.movementChallenge: return Icons.directions_run_rounded;
      case TaskCategory.homeHelper: return Icons.home_rounded;
    }
  }
}
