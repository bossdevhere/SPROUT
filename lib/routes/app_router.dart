import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprout/features/home/home_screen.dart';
import 'package:sprout/features/stories/stories_screen.dart';
import 'package:sprout/features/quizzes/quiz_screen.dart';
import 'package:sprout/features/quizzes/math_quiz_screen.dart';
import 'package:sprout/features/quizzes/animal_sound_quiz_screen.dart';
import 'package:sprout/features/quizzes/count_stars_screen.dart';
import 'package:sprout/features/rewards/rewards_screen.dart';
import 'package:sprout/features/customization/customization_screen.dart';
import 'package:sprout/features/splash/splash_screen.dart';

import 'package:sprout/features/tasks/tasks_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/stories',
            builder: (context, state) => const StoriesScreen(),
          ),
          GoRoute(
            path: '/quiz',
            builder: (context, state) => const QuizScreen(),
          ),
          GoRoute(
            path: '/rewards',
            builder: (context, state) => const RewardsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/customization',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CustomizationScreen(),
      ),
      GoRoute(
        path: '/tasks',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TasksScreen(),
      ),
      GoRoute(
        path: '/math-quiz/:operation',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final operationStr = state.pathParameters['operation']!;
          final operation = MathOperation.values.firstWhere(
            (e) => e.name == operationStr,
            orElse: () => MathOperation.addition,
          );
          return MathQuizScreen(operation: operation);
        },
      ),
      GoRoute(
        path: '/animal-sound-quiz',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AnimalSoundQuizScreen(),
      ),
      GoRoute(
        path: '/count-the-stars',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CountStarsScreen(),
      ),
    ],
  );
}

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Stories',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.lightbulb_rounded),
            label: 'Quiz',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_rounded),
            label: 'Rewards',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/stories') return 0;
    if (location == '/') return 1;
    if (location == '/quiz') return 2;
    if (location == '/rewards') return 3;
    return 1;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/stories');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/quiz');
        break;
      case 3:
        context.go('/rewards');
        break;
    }
  }
}
