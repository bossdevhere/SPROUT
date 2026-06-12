import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprout/core/constants/app_colors.dart';
import 'package:sprout/providers/user_provider.dart';
import 'package:sprout/widgets/character_widget.dart';

class CustomizationScreen extends StatelessWidget {
  const CustomizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final customization = userProvider.characterCustomization;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Me', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Preview
          Center(
            child: CharacterWidget(
              customization: customization,
              size: 250,
            ),
          ),
          const SizedBox(height: 40),
          
          // Controls
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView(
                children: [
                  _buildSectionTitle('My Name'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.black.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person_rounded, color: AppColors.softPurple),
                    ),
                    controller: TextEditingController(text: userProvider.userProgress.name)
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: userProvider.userProgress.name.length),
                      ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        userProvider.updateName(value);
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Hair Color'),
                  _buildColorPicker(
                    selectedColor: Color(customization.hairColor),
                    colors: [
                      const Color(0xFF4E342E),
                      const Color(0xFF3E2723),
                      const Color(0xFFFBC02D),
                      const Color(0xFFFFCC80),
                      const Color(0xFF8D6E63),
                    ],
                    onSelected: (color) {
                      userProvider.updateCustomization(
                        customization.copyWith(hairColor: color.toARGB32()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Shirt Color'),
                  _buildColorPicker(
                    selectedColor: Color(customization.shirtColor),
                    colors: [
                      AppColors.softPurple,
                      AppColors.skyBlue,
                      AppColors.mintGreen,
                      AppColors.warmYellow,
                      const Color(0xFFFFAB91),
                    ],
                    onSelected: (color) {
                      userProvider.updateCustomization(
                        customization.copyWith(shirtColor: color.toARGB32()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Pants Color'),
                  _buildColorPicker(
                    selectedColor: Color(customization.pantsColor),
                    colors: [
                      const Color(0xFF81D4FA),
                      const Color(0xFF1E88E5),
                      const Color(0xFFB0BEC5),
                      const Color(0xFF424242),
                      const Color(0xFF37474F),
                    ],
                    onSelected: (color) {
                      userProvider.updateCustomization(
                        customization.copyWith(pantsColor: color.toARGB32()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Skin Tone'),
                  _buildColorPicker(
                    selectedColor: Color(customization.skinTone),
                    colors: [
                      const Color(0xFFFFCCBC),
                      const Color(0xFFFFE0B2),
                      const Color(0xFFD7CCC8),
                      const Color(0xFFA1887F),
                      const Color(0xFF8D6E63),
                    ],
                    onSelected: (color) {
                      userProvider.updateCustomization(
                        customization.copyWith(skinTone: color.toARGB32()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
    );
  }

  Widget _buildColorPicker({
    required Color selectedColor,
    required List<Color> colors,
    required Function(Color) onSelected,
  }) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final color = colors[index];
          final isSelected = color.toARGB32() == selectedColor.toARGB32();
          
          return GestureDetector(
            onTap: () => onSelected(color),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.black, width: 3)
                    : Border.all(color: Colors.black12, width: 1),
                boxShadow: isSelected
                    ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)]
                    : [],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 30)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
