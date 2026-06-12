import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:sprout/providers/user_provider.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final userProgress = userProvider.userProgress;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalStarsCard(userProgress.stars),
            const SizedBox(height: 32),
            _buildSectionTitle('Achievements'),
            const SizedBox(height: 16),
            _buildAchievementsList(userProgress.streak, userProgress.stars),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalStarsCard(int stars) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.softPurple, AppColors.skyBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.softPurple.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.stars_rounded, color: AppColors.starGold, size: 80),
          const SizedBox(height: 16),
          Text(
            stars.toString(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'Total Stars Earned',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildAchievementsList(int streak, int stars) {
    return Column(
      children: [
        _buildAchievementItem(
          '7 Day Streak',
          'Complete tasks for 7 days in a row',
          streak / 7,
          '$streak/7',
        ),
        const SizedBox(height: 16),
        _buildAchievementItem(
          'Star Collector',
          'Earn 500 stars',
          stars / 500,
          '$stars/500',
        ),
      ],
    );
  }

  Widget _buildAchievementItem(String title, String desc, double progress, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.softPurple)),
            ],
          ),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: AppColors.lightText, fontSize: 13)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: Colors.black12,
              color: AppColors.skyBlue,
            ),
          ),
        ],
      ),
    );
  }
}
