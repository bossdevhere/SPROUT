import 'package:flutter/material.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:sprout/features/stories/story_player_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'title': 'Lion and Rabbit',
        'videoPath': 'lib/datarequired/stories/lion_and_rabbit.mp4',
        'moral': 'Wisdom is stronger than physical strength.',
        'image': '🦁',
        'color': AppColors.softPurple
      },
      {
        'title': 'Rabbit and Tortoise',
        'videoPath': 'lib/datarequired/stories/rabbit_and_tortoise.mp4',
        'moral': 'Slow and steady wins the race.',
        'image': '🐢',
        'color': AppColors.nature
      },
      {
        'title': 'Rat and Rabbit',
        'videoPath': 'lib/datarequired/stories/rat_and_rabbit.mp4',
        'moral': 'A friend in need is a friend indeed.',
        'image': '🐭',
        'color': AppColors.mintGreen
      },
      {
        'title': 'The Thirsty Crow',
        'videoPath': 'lib/datarequired/stories/the_thirsty_crow.mp4',
        'moral': 'Where there is a will, there is a way.',
        'image': '🐦',
        'color': AppColors.skyBlue
      },
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryPlayerScreen(
                    title: story['title'] as String,
                    videoPath: story['videoPath'] as String,
                    moral: story['moral'] as String,
                  ),
                ),
              );
            },
            child: Container(
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
            ),
          );
        },
      ),
    );
  }
}
