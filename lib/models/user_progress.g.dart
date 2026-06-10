// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressAdapter extends TypeAdapter<UserProgress> {
  @override
  final int typeId = 1;

  @override
  UserProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgress(
      name: fields[0] as String,
      stars: fields[1] as int,
      streak: fields[2] as int,
      lastLoginDate: fields[3] as DateTime?,
      unlockedBadges: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.stars)
      ..writeByte(2)
      ..write(obj.streak)
      ..writeByte(3)
      ..write(obj.lastLoginDate)
      ..writeByte(4)
      ..write(obj.unlockedBadges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
