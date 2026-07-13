import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsets padding;
  final double height;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.2,
    this.padding = const EdgeInsets.all(20),
    this.height = 400, // Added height with default
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: height, // Use the height parameter
      borderRadius: 20,
      blur: blur,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(opacity),
          Colors.white.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.1),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}