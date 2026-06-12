import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sprout/models/character_customization.dart';

class CharacterWidget extends StatelessWidget {
  final CharacterCustomization customization;
  final double size;
  final bool isAnimated;
  final bool isInteracting;

  const CharacterWidget({
    super.key,
    required this.customization,
    this.size = 200,
    this.isAnimated = true,
    this.isInteracting = false,
  });

  @override
  Widget build(BuildContext context) {
    var content = SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Body (Shirt)
          Positioned(
            bottom: size * 0.1,
            child: Container(
              width: size * 0.4,
              height: size * 0.5,
              decoration: BoxDecoration(
                color: Color(customization.shirtColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size * 0.15),
                  topRight: Radius.circular(size * 0.15),
                  bottomLeft: Radius.circular(size * 0.05),
                  bottomRight: Radius.circular(size * 0.05),
                ),
              ),
            ),
          ),
          
          // Pants
          Positioned(
            bottom: size * 0.05,
            child: Container(
              width: size * 0.4,
              height: size * 0.1,
              decoration: BoxDecoration(
                color: Color(customization.pantsColor),
                borderRadius: BorderRadius.circular(size * 0.02),
              ),
            ),
          ),

          // Head
          Positioned(
            top: size * 0.15,
            child: Container(
              width: size * 0.5,
              height: size * 0.5,
              decoration: BoxDecoration(
                color: Color(customization.skinTone),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Rosy Cheeks
                  Positioned(
                    top: size * 0.28,
                    left: size * 0.08,
                    child: _buildBlush(size),
                  ),
                  Positioned(
                    top: size * 0.28,
                    right: size * 0.08,
                    child: _buildBlush(size),
                  ),

                  // Eyes
                  Positioned(
                    top: size * 0.18,
                    left: size * 0.12,
                    child: _buildEye(size),
                  ),
                  Positioned(
                    top: size * 0.18,
                    right: size * 0.12,
                    child: _buildEye(size),
                  ),

                  // Eyebrows
                  Positioned(
                    top: size * 0.13,
                    left: size * 0.12,
                    child: _buildEyebrow(size),
                  ),
                  Positioned(
                    top: size * 0.13,
                    right: size * 0.12,
                    child: _buildEyebrow(size),
                  ),
                  
                  // Smile
                  Positioned(
                    bottom: size * 0.1,
                    left: size * 0.15,
                    right: size * 0.15,
                    child: Center(
                      child: Container(
                        width: size * 0.15,
                        height: size * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.4),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hair (Simplified representation)
          Positioned(
            top: size * 0.1,
            child: Container(
              width: size * 0.52,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: Color(customization.hairColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size * 0.25),
                  topRight: Radius.circular(size * 0.25),
                  bottomLeft: Radius.circular(size * 0.05),
                  bottomRight: Radius.circular(size * 0.05),
                ),
              ),
            ),
          ),

          // Waving Hand (Only when interacting)
          if (isInteracting)
            Positioned(
              right: 0,
              top: size * 0.3,
              child: Container(
                width: size * 0.12,
                height: size * 0.12,
                decoration: BoxDecoration(
                  color: Color(customization.skinTone),
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .rotate(begin: -0.2, end: 0.2, duration: 200.ms),
            ),
        ],
      ),
    );

    if (isInteracting) {
      return content
          .animate()
          .moveY(begin: 0, end: -40, duration: 300.ms, curve: Curves.easeOut)
          .then()
          .moveY(begin: 0, end: 40, duration: 300.ms, curve: Curves.bounceOut);
    }

    return content
        .animate(
          onPlay: (controller) => isAnimated ? controller.repeat(reverse: true) : null,
        )
        .moveY(
          begin: 0,
          end: -10,
          duration: 1500.ms,
          curve: Curves.easeInOut,
        )
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.05, 0.95), // Breathing/Squashing effect
          duration: 1500.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildEye(double size) {
    return Container(
      width: size * 0.08,
      height: size * 0.08,
      decoration: const BoxDecoration(
        color: Colors.black87,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            left: 2,
            child: Container(
              width: size * 0.02,
              height: size * 0.02,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    )
    .animate(
      onPlay: (controller) => isAnimated ? controller.repeat(reverse: false) : null,
    )
    .scaleY(
      begin: 1.0,
      end: 0.1,
      duration: 150.ms,
      delay: 4000.ms,
    )
    .then()
    .scaleY(
      begin: 0.1,
      end: 1.0,
      duration: 150.ms,
    );
  }

  Widget _buildBlush(double size) {
    return Container(
      width: size * 0.08,
      height: size * 0.04,
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(size * 0.04),
      ),
    ).animate(
      onPlay: (controller) => isAnimated ? controller.repeat(reverse: true) : null,
    ).fadeIn(duration: 2000.ms);
  }

  Widget _buildEyebrow(double size) {
    return Container(
      width: size * 0.08,
      height: size * 0.015,
      decoration: BoxDecoration(
        color: Color(customization.hairColor).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(size * 0.01),
      ),
    ).animate(
      onPlay: (controller) => isAnimated ? controller.repeat(reverse: true) : null,
    ).moveY(begin: 0, end: -3, duration: 1500.ms);
  }
}
