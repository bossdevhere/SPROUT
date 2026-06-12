import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprout/core/constants/app_colors.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizzes = [
      {'title': 'Addition', 'icon': Icons.add_rounded, 'color': AppColors.softPurple, 'route': '/math-quiz/addition'},
      {'title': 'Subtraction', 'icon': Icons.remove_rounded, 'color': AppColors.skyBlue, 'route': '/math-quiz/subtraction'},
      {'title': 'Multiplication', 'icon': Icons.close_rounded, 'color': AppColors.mintGreen, 'route': '/math-quiz/multiplication'},
      {'title': 'Division', 'icon': Icons.horizontal_rule_rounded, 'color': AppColors.warmYellow, 'route': '/math-quiz/division'},
      {'title': 'Count the Stars', 'icon': Icons.star_rounded, 'color': AppColors.starGold, 'route': '/count-the-stars'},
      {'title': 'Animal Sounds', 'icon': Icons.pets_rounded, 'color': AppColors.nature, 'route': '/animal-sound-quiz'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fun Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return InkWell(
            onTap: () {
              if (quiz.containsKey('route')) {
                context.push(quiz['route'] as String);
              }
            },
            borderRadius: BorderRadius.circular(32),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: (quiz['color'] as Color).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      quiz['icon'] as IconData,
                      size: 40,
                      color: quiz['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    quiz['title'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap to Play!',
                    style: TextStyle(
                      color: AppColors.lightText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
