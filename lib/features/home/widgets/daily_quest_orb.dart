import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sprout/core/constants/app_colors.dart';

class DailyQuestOrb extends StatelessWidget {
  final VoidCallback onTap;
  final bool isCompleted;

  const DailyQuestOrb({
    super.key,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow Effect
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isCompleted ? AppColors.starGold : AppColors.softPurple).withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
          )
          .animate(onPlay: (c) => c.repeat())
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2000.ms, curve: Curves.easeInOut)
          .blur(begin: const Offset(10, 10), end: const Offset(20, 20)),

          // Main Orb
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: isCompleted 
                    ? [Colors.white, AppColors.starGold, Colors.orangeAccent]
                    : [Colors.white, AppColors.softPurple, Colors.deepPurpleAccent],
                stops: const [0.1, 0.6, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
          .animate(onPlay: (c) => c.repeat())
          .shimmer(duration: 3000.ms, color: Colors.white54)
          .moveY(begin: 0, end: -10, duration: 1500.ms, curve: Curves.easeInOut),
          
          // Particles (Simplified)
          ...List.generate(5, (index) {
            return Positioned(
              child: const Icon(Icons.star, color: Colors.white, size: 10)
                .animate(onPlay: (c) => c.repeat())
                .move(
                  begin: const Offset(0, 0),
                  end: Offset((index - 2) * 30.0, (index - 2) * -30.0),
                  duration: (1000 + index * 200).ms,
                )
                .fadeOut(),
            );
          }),
        ],
      ),
    );
  }
}
