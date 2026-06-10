// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyTaskAdapter extends TypeAdapter<DailyTask> {
  @override
  final int typeId = 4;

  @override
  DailyTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTask(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as TaskCategory,
      progress: fields[4] as int,
      goal: fields[5] as int,
      status: fields[6] as TaskStatus,
      date: fields[7] as DateTime?,
      photoPaths: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyTask obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.progress)
      ..writeByte(5)
      ..write(obj.goal)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.photoPaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 2;

  @override
  TaskCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskCategory.nature;
      case 1:
        return TaskCategory.colorHunt;
      case 2:
        return TaskCategory.shapeDetective;
      case 3:
        return TaskCategory.soundExplorer;
      case 4:
        return TaskCategory.movementChallenge;
      case 5:
        return TaskCategory.homeHelper;
      default:
        return TaskCategory.nature;
    }
  }

  @override
  void write(BinaryWriter writer, TaskCategory obj) {
    switch (obj) {
      case TaskCategory.nature:
        writer.writeByte(0);
        break;
      case TaskCategory.colorHunt:
        writer.writeByte(1);
        break;
      case TaskCategory.shapeDetective:
        writer.writeByte(2);
        break;
      case TaskCategory.soundExplorer:
        writer.writeByte(3);
        break;
      case TaskCategory.movementChallenge:
        writer.writeByte(4);
        break;
      case TaskCategory.homeHelper:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskStatusAdapter extends TypeAdapter<TaskStatus> {
  @override
  final int typeId = 3;

  @override
  TaskStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatus.locked;
      case 1:
        return TaskStatus.active;
      case 2:
        return TaskStatus.completed;
      default:
        return TaskStatus.locked;
    }
  }

  @override
  void write(BinaryWriter writer, TaskStatus obj) {
    switch (obj) {
      case TaskStatus.locked:
        writer.writeByte(0);
        break;
      case TaskStatus.active:
        writer.writeByte(1);
        break;
      case TaskStatus.completed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
