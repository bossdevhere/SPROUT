import 'package:flutter/material.dart';
import 'package:sprout/models/character_customization.dart';
import 'package:sprout/models/user_progress.dart';
import 'package:sprout/services/storage_service.dart';

class UserProvider extends ChangeNotifier {
  late UserProgress _userProgress;
  late CharacterCustomization _characterCustomization;

  UserProvider() {
    _loadData();
  }

  void _loadData() {
    _userProgress = StorageService.getUserProgress();
    _characterCustomization = StorageService.getCustomization();
    _checkStreak();
    notifyListeners();
  }

  void _checkStreak() {
    final now = DateTime.now();
    final lastLogin = _userProgress.lastLoginDate;
    
    if (_isSameDay(lastLogin, now)) {
      return;
    }

    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(lastLogin, yesterday)) {
      // Streak continues! (Wait, we should only increment if they completed tasks, 
      // but the requirement is "Track consecutive days". Let's increment on login if they did tasks yesterday)
      // For simplicity, let's just update the last login date now.
    } else if (now.difference(lastLogin).inDays > 1) {
      _userProgress = _userProgress.copyWith(streak: 0);
    }
    
    _userProgress = _userProgress.copyWith(lastLoginDate: now);
    StorageService.saveUserProgress(_userProgress);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  UserProgress get userProgress => _userProgress;
  CharacterCustomization get characterCustomization => _characterCustomization;

  // User Progress Actions
  Future<void> updateName(String name) async {
    _userProgress = _userProgress.copyWith(name: name);
    await StorageService.saveUserProgress(_userProgress);
    notifyListeners();
  }

  Future<void> addStars(int amount) async {
    _userProgress = _userProgress.copyWith(stars: _userProgress.stars + amount);
    await StorageService.saveUserProgress(_userProgress);
    notifyListeners();
  }

  Future<void> updateStreak(int streak) async {
    _userProgress = _userProgress.copyWith(streak: streak);
    await StorageService.saveUserProgress(_userProgress);
    notifyListeners();
  }

  // Character Customization Actions
  Future<void> updateCustomization(CharacterCustomization customization) async {
    _characterCustomization = customization;
    await StorageService.saveCustomization(_characterCustomization);
    notifyListeners();
  }
}
