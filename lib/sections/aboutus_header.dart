import 'dart:async';
import 'package:flutter/material.dart';

class AboutusHeroSection extends StatefulWidget {
  const AboutusHeroSection({super.key});

  @override
  _AboutusHeroSection createState() => _AboutusHeroSection();
}

class _AboutusHeroSection extends State<AboutusHeroSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _images = [
    'assets/modular_interior.webp',
    'assets/modular_kitchen.webp',

  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _images.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    if (_pageController.hasClients) {
      _currentPage = _currentPage > 0 ? _currentPage - 1 : _images.length - 1;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_pageController.hasClients) {
      _currentPage = (_currentPage + 1) % _images.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 1200;

    // Calculate height based on screen size
    final double height = isLargeScreen
        ? screenSize.height * 0.8  // 80% on large screens
        : screenSize.height * 0.6; // 60% on normal screens

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // PageView with images
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => Image.asset(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0.1, 0.5],
              ),
            ),
          ),

          // Text Overlay
          Positioned(
            left: isLargeScreen ? screenSize.width * 0.1 : 40,
            bottom: height * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

              ],
            ),
          ),

          // Navigation Arrows
          if (isLargeScreen) ...[
            // Previous Button
            Positioned(
              left: 40,
              top: height / 2 - 30,
              child: _NavButton(
                icon: Icons.arrow_back_ios,
                onTap: _goToPrevious,
              ),
            ),
            // Next Button
            Positioned(
              right: 40,
              top: height / 2 - 30,
              child: _NavButton(
                icon: Icons.arrow_forward_ios,
                onTap: _goToNext,
              ),
            ),
          ],

          // Page Indicators
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                return GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 4,
                    width: _currentPage == index ? 40 : 30,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}