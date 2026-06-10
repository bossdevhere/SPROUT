import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:sprout/features/home/widgets/daily_quest_orb.dart';
import 'package:sprout/features/home/widgets/progress_card.dart';
import 'package:sprout/providers/task_provider.dart';
import 'package:sprout/providers/user_provider.dart';
import 'package:sprout/widgets/character_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCharacterInteracting = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final userProgress = userProvider.userProgress;
    final customization = userProvider.characterCustomization;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sprout',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Customize Me Button
              ElevatedButton.icon(
                onPressed: () => context.push('/customization'),
                icon: const Icon(Icons.palette_rounded),
                label: const Text('Customize Me'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.skyBlue,
                ),
              ),
              const SizedBox(height: 32),

              // Character
              GestureDetector(
                onTap: () {
                  if (!_isCharacterInteracting) {
                    setState(() {
                      _isCharacterInteracting = true;
                    });
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      if (mounted) {
                        setState(() {
                          _isCharacterInteracting = false;
                        });
                      }
                    });
                  }
                },
                child: CharacterWidget(
                  customization: customization,
                  size: 220,
                  isInteracting: _isCharacterInteracting,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              Text(
                userProgress.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 32),

              // Progress Card
              ProgressCard(
                stars: userProgress.stars,
                streak: userProgress.streak,
                completedTasks:
                    '${taskProvider.completedTasksCount}/${taskProvider.tasks.length}',
              ),
              const SizedBox(height: 48),

              // Daily Quest Orb
              DailyQuestOrb(
                onTap: () => context.push('/tasks'),
                isCompleted: taskProvider.allTasksCompleted,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
