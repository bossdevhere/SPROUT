import 'package:flutter/material.dart';
import 'package:sprout/core/constants/app_colors.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {'title': 'The Lost Bunny', 'image': '🐰', 'color': AppColors.softPurple},
      {'title': 'Forest Adventure', 'image': '🌲', 'color': AppColors.nature},
      {'title': 'Friendly Dinosaur', 'image': '🦖', 'color': AppColors.mintGreen},
      {'title': 'Space Trip', 'image': '🚀', 'color': AppColors.skyBlue},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Time', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: story['color'] as Color,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: (story['color'] as Color).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    story['image'] as String,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          story['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
