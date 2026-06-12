import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CountStarsScreen extends StatefulWidget {
  const CountStarsScreen({super.key});

  @override
  State<CountStarsScreen> createState() => _CountStarsScreenState();
}

class _CountStarsScreenState extends State<CountStarsScreen> {
  final Random _random = Random();
  late int _starCount;
  final TextEditingController _controller = TextEditingController();
  String _feedback = '';
  bool _showCorrectAnswer = false;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _generateStars();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateStars() {
    setState(() {
      _starCount = _random.nextInt(15) + 1; // 1 to 15 stars
      _controller.clear();
      _feedback = '';
      _showCorrectAnswer = false;
      _isAnswered = false;
    });
  }

  void _checkAnswer() {
    if (_controller.text.isEmpty) return;

    final int? userAnswer = int.tryParse(_controller.text);
    
    setState(() {
      _isAnswered = true;
      if (userAnswer == _starCount) {
        _feedback = 'Correct! 🎉';
      } else {
        _feedback = 'Incorrect! 😊';
        _showCorrectAnswer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Count the Stars'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                'How many stars do you see?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 40),
              // Stars Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      _starCount,
                      (index) => const Icon(
                        Icons.star_rounded,
                        size: 50,
                        color: AppColors.starGold,
                      ).animate().scale(delay: (index * 50).ms, duration: 300.ms, curve: Curves.easeOutBack),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Input Field
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: !_isAnswered,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: '?',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _checkAnswer(),
                ),
              ),
              const SizedBox(height: 32),
              // Action Button
              if (!_isAnswered)
                ElevatedButton(
                  onPressed: _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.starGold,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 4,
                  ),
                  child: const Text('Check', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )
              else
                ElevatedButton(
                  onPressed: _generateStars,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.softPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 4,
                  ),
                  child: const Text('Next Question', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 32),
              // Feedback
              if (_isAnswered)
                Column(
                  children: [
                    Text(
                      _feedback,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _feedback.contains('Correct') ? AppColors.success : Colors.orange,
                      ),
                    ).animate().fade().scale(),
                    if (_showCorrectAnswer)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'The correct answer is $_starCount',
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.lightText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fade(delay: 500.ms),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
