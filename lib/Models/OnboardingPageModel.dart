import 'dart:ui';

class OnboardingPageModel {
  final String imagePath; // Path to SVG or Lottie asset
  final String title;
  final String description;
  final Color backgroundColor; // Or gradient start/end colors

  OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}
