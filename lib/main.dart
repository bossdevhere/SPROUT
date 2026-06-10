import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/core/theme/app_theme.dart';
import 'package:sprout/providers/task_provider.dart';
import 'package:sprout/providers/user_provider.dart';
import 'package:sprout/routes/app_router.dart';
import 'package:sprout/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Storage Service
  await StorageService.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const SproutApp(),
    ),
  );
}

class SproutApp extends StatelessWidget {
  const SproutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sprout',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
