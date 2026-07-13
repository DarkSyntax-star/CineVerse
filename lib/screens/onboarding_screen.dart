
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      image: 'assets/images/onboarding1.png',
      title: 'Discover Movies',
      description: 'Find the latest and greatest movies from around the world.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      title: 'Create Your List',
      description: 'Save your favorites and keep track of what to watch next.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      title: 'Watch Trailers',
      description: 'Preview movies before you decide to watch them.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return _buildPage(items[index]);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(items.length, (i) => _buildDot(i)),
                const Spacer(),
                if (_currentPage == items.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('seen_onboarding', true);
                        context.go('/auth/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white),
                      ),
                    ).animate().fadeIn(duration: 500.ms),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.red.shade900],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.grey[300],
            child: Center(child: Icon(Icons.movie, size: 80, color: Colors.grey[600])),
          ),
          const SizedBox(height: 40),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 20),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _currentPage == index ? Colors.red : Colors.white54,
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
