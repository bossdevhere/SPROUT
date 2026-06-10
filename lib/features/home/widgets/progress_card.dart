import 'package:flutter/material.dart';
import 'package:sprout/core/constants/app_colors.dart';

class ProgressCard extends StatelessWidget {
  final int stars;
  final int streak;
  final String completedTasks;

  const ProgressCard({
    super.key,
    required this.stars,
    required this.streak,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat(Icons.star_rounded, AppColors.starGold, 'Stars', stars.toString()),
                _buildStat(Icons.local_fire_department_rounded, AppColors.streakOrange, 'Streak', '$streak Days'),
                _buildStat(Icons.check_circle_rounded, AppColors.success, 'Tasks', completedTasks),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, Color color, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.lightText)),
      ],
    );
  }
}
