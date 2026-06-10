import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprout/core/constants/app_colors.dart';

enum MathOperation { addition, subtraction, multiplication, division }

class MathQuizScreen extends StatefulWidget {
  final MathOperation operation;

  const MathQuizScreen({super.key, required this.operation});

  @override
  State<MathQuizScreen> createState() => _MathQuizScreenState();
}

class _MathQuizScreenState extends State<MathQuizScreen> {
  late int num1;
  late int num2;
  final TextEditingController _answerController = TextEditingController();
  final Random _random = Random();
  String _feedback = '';

  @override
  void initState() {
    super.initState();
    _generateNumbers();
  }

  void _generateNumbers() {
    setState(() {
      _answerController.clear();
      _feedback = '';
      switch (widget.operation) {
        case MathOperation.addition:
          num1 = _random.nextInt(50) + 1;
          num2 = _random.nextInt(50) + 1;
          break;
        case MathOperation.subtraction:
          num1 = _random.nextInt(50) + 20;
          num2 = _random.nextInt(num1 - 1) + 1;
          break;
        case MathOperation.multiplication:
          num1 = _random.nextInt(12) + 1;
          num2 = _random.nextInt(12) + 1;
          break;
        case MathOperation.division:
          num2 = _random.nextInt(10) + 1;
          int factor = _random.nextInt(10) + 1;
          num1 = num2 * factor;
          break;
      }
    });
  }

  void _checkAnswer() {
    final int? userAnswer = int.tryParse(_answerController.text);
    if (userAnswer == null) return;

    int correctAnswer;
    switch (widget.operation) {
      case MathOperation.addition:
        correctAnswer = num1 + num2;
        break;
      case MathOperation.subtraction:
        correctAnswer = num1 - num2;
        break;
      case MathOperation.multiplication:
        correctAnswer = num1 * num2;
        break;
      case MathOperation.division:
        correctAnswer = num1 ~/ num2;
        break;
    }

    setState(() {
      if (userAnswer == correctAnswer) {
        _feedback = 'Correct! 🎉';
        Future.delayed(const Duration(seconds: 1), _generateNumbers);
      } else {
        _feedback = 'Try again! 😊';
      }
    });
  }

  String get _operationSymbol {
    switch (widget.operation) {
      case MathOperation.addition: return '+';
      case MathOperation.subtraction: return '-';
      case MathOperation.multiplication: return '×';
      case MathOperation.division: return '÷';
    }
  }

  String get _title {
    return widget.operation.name[0].toUpperCase() + widget.operation.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$num1', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(_operationSymbol, style: const TextStyle(fontSize: 40, color: AppColors.softPurple)),
                  ),
                  Text('$num2', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('=', style: TextStyle(fontSize: 40, color: AppColors.softPurple)),
                  ),
                  const Text('?', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.lightText)),

                ],
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _answerController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Enter answer',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
              ),
              onSubmitted: (_) => _checkAnswer(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.softPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Check', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            Text(
              _feedback,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _feedback.contains('Correct') ? AppColors.success : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
