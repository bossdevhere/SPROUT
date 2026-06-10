import 'package:hive/hive.dart';

part 'character_customization.g.dart';

@HiveType(typeId: 0)
class CharacterCustomization extends HiveObject {
  @HiveField(0)
  String hairStyle;

  @HiveField(1)
  int hairColor;

  @HiveField(2)
  int shirtColor;

  @HiveField(3)
  int pantsColor;

  @HiveField(4)
  int skinTone;

  @HiveField(5)
  String? accessory;

  CharacterCustomization({
    this.hairStyle = 'default',
    this.hairColor = 0xFF4E342E,
    this.shirtColor = 0xFFB39DDB,
    this.pantsColor = 0xFF81D4FA,
    this.skinTone = 0xFFFFCCBC,
    this.accessory,
  });

  CharacterCustomization copyWith({
    String? hairStyle,
    int? hairColor,
    int? shirtColor,
    int? pantsColor,
    int? skinTone,
    String? accessory,
  }) {
    return CharacterCustomization(
      hairStyle: hairStyle ?? this.hairStyle,
      hairColor: hairColor ?? this.hairColor,
      shirtColor: shirtColor ?? this.shirtColor,
      pantsColor: pantsColor ?? this.pantsColor,
      skinTone: skinTone ?? this.skinTone,
      accessory: accessory ?? this.accessory,
    );
  }
}
