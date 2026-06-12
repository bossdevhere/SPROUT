import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:sprout/core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.skyBlue.withValues(alpha: 0.8),
              AppColors.mintGreen.withValues(alpha: 0.5),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background bubbles
            ...List.generate(5, (index) {
              return Positioned(
                left: (index * 100) - 50,
                top: (index * 150) % MediaQuery.of(context).size.height,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .moveY(begin: 0, end: 30, duration: (2000 + index * 500).ms)
                    .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
              );
            }),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/App Icon Placeholder
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '🌱',
                        style: TextStyle(fontSize: 80),
                      ),
                    ),
                  )
                      .animate()
                      .scale(
                        duration: 800.ms,
                        curve: Curves.elasticOut,
                        begin: const Offset(0, 0),
                      )
                      .shimmer(delay: 1200.ms, duration: 1500.ms),
                  
                  const SizedBox(height: 40),
                  
                  // App Name
                  Text(
                    'SPROUT',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 8,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 12),
                  
                  // Tagline
                  Text(
                    'Grow & Learn Every Day',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 1.2,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms)
                      .slideY(begin: 0.5, end: 0),
                  
                  const SizedBox(height: 60),
                  
                  // Loading indicator
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1500.ms)
                      .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
