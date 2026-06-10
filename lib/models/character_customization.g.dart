// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_customization.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterCustomizationAdapter
    extends TypeAdapter<CharacterCustomization> {
  @override
  final int typeId = 0;

  @override
  CharacterCustomization read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterCustomization(
      hairStyle: fields[0] as String,
      hairColor: fields[1] as int,
      shirtColor: fields[2] as int,
      pantsColor: fields[3] as int,
      skinTone: fields[4] as int,
      accessory: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterCustomization obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hairStyle)
      ..writeByte(1)
      ..write(obj.hairColor)
      ..writeByte(2)
      ..write(obj.shirtColor)
      ..writeByte(3)
      ..write(obj.pantsColor)
      ..writeByte(4)
      ..write(obj.skinTone)
      ..writeByte(5)
      ..write(obj.accessory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterCustomizationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
