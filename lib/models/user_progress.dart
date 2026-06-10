import 'package:hive/hive.dart';

part 'user_progress.g.dart';

@HiveType(typeId: 1)
class UserProgress extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int stars;

  @HiveField(2)
  int streak;

  @HiveField(3)
  DateTime lastLoginDate;

  @HiveField(4)
  List<String> unlockedBadges;

  UserProgress({
    this.name = 'My Friend',
    this.stars = 0,
    this.streak = 0,
    DateTime? lastLoginDate,
    this.unlockedBadges = const [],
  }) : lastLoginDate = lastLoginDate ?? DateTime.now();

  UserProgress copyWith({
    String? name,
    int? stars,
    int? streak,
    DateTime? lastLoginDate,
    List<String>? unlockedBadges,
  }) {
    return UserProgress(
      name: name ?? this.name,
      stars: stars ?? this.stars,
      streak: streak ?? this.streak,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
    );
  }
}
