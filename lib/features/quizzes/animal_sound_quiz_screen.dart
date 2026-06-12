import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimalInfo {
  final String name;
  final String imagePath;
  final String soundPath;

  AnimalInfo({
    required this.name,
    required this.imagePath,
    required this.soundPath,
  });
}

class AnimalSoundQuizScreen extends StatefulWidget {
  const AnimalSoundQuizScreen({super.key});

  @override
  State<AnimalSoundQuizScreen> createState() => _AnimalSoundQuizScreenState();
}

class _AnimalSoundQuizScreenState extends State<AnimalSoundQuizScreen> {
  final List<AnimalInfo> _animals = [
    AnimalInfo(name: 'Cat', imagePath: 'lib/datarequired/animals/animalimages/cat.png', soundPath: 'lib/datarequired/animals/animalsounds/cat.wav'),
    AnimalInfo(name: 'Chicken', imagePath: 'lib/datarequired/animals/animalimages/chicken.png', soundPath: 'lib/datarequired/animals/animalsounds/chicken.wav'),
    AnimalInfo(name: 'Cow', imagePath: 'lib/datarequired/animals/animalimages/cow.png', soundPath: 'lib/datarequired/animals/animalsounds/cow.wav'),
    AnimalInfo(name: 'Cricket', imagePath: 'lib/datarequired/animals/animalimages/cricket.png', soundPath: 'lib/datarequired/animals/animalsounds/cricket.wav'),
    AnimalInfo(name: 'Dog', imagePath: 'lib/datarequired/animals/animalimages/dog.png', soundPath: 'lib/datarequired/animals/animalsounds/dog.wav'),
    AnimalInfo(name: 'Horse', imagePath: 'lib/datarequired/animals/animalimages/horse.png', soundPath: 'lib/datarequired/animals/animalsounds/horse.wav'),
    AnimalInfo(name: 'Lion', imagePath: 'lib/datarequired/animals/animalimages/lion.png', soundPath: 'lib/datarequired/animals/animalsounds/lion.wav'),
    AnimalInfo(name: 'Monkey', imagePath: 'lib/datarequired/animals/animalimages/monkey.png', soundPath: 'lib/datarequired/animals/animalsounds/monkey.wav'),
    AnimalInfo(name: 'Pig', imagePath: 'lib/datarequired/animals/animalimages/pig.png', soundPath: 'lib/datarequired/animals/animalsounds/pig.wav'),
    AnimalInfo(name: 'Wolf', imagePath: 'lib/datarequired/animals/animalimages/wolf.png', soundPath: 'lib/datarequired/animals/animalsounds/wolf.wav'),
  ];

  late AnimalInfo _currentAnimal;
  late List<AnimalInfo> _options;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();
  String _feedback = '';
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.audioCache.prefix = ''; // Support paths outside default assets/ folder
    _generateQuestion();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _generateQuestion() {
    setState(() {
      _feedback = '';
      _isCorrect = false;
      _currentAnimal = _animals[_random.nextInt(_animals.length)];
      
      List<AnimalInfo> others = _animals.where((a) => a.name != _currentAnimal.name).toList();
      others.shuffle();
      _options = [
        _currentAnimal,
        others[0],
        others[1],
        others[2],
      ];
      _options.shuffle();
    });
  }

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(_currentAnimal.soundPath));
  }

  void _checkAnswer(AnimalInfo selected) {
    if (_isCorrect) return; // Prevent multiple clicks after correct answer

    setState(() {
      if (selected.name == _currentAnimal.name) {
        _feedback = 'Correct! 🎉';
        _isCorrect = true;
        Future.delayed(const Duration(seconds: 2), _generateQuestion);
      } else {
        _feedback = 'Try again! 😊';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Animal Sounds Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Listen and Choose!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 40),
              // Sound Play Button
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _playSound,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.soundExplorer,
                        foregroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(40),
                        elevation: 8,
                        shadowColor: AppColors.soundExplorer.withValues(alpha: 0.5),
                      ),
                      child: const Icon(
                        Icons.volume_up_rounded,
                        size: 80,
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(),
                    ).shimmer(duration: 2.seconds),
                    const SizedBox(height: 12),
                    const Text(
                      'Tap to Hear Sound',
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Options Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    return InkWell(
                      onTap: () => _checkAnswer(option),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _isCorrect && option.name == _currentAnimal.name
                                ? AppColors.success
                                : Colors.black12,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            option.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ).animate(target: _isCorrect && option.name == _currentAnimal.name ? 1 : 0)
                      .scale(duration: 300.ms, begin: const Offset(1, 1), end: const Offset(1.1, 1.1));
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _feedback,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _feedback.contains('Correct') ? AppColors.success : Colors.orange,
                ),
              ).animate(target: _feedback.isEmpty ? 0 : 1).fade().scale(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
