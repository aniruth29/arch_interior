import 'dart:async';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class AboutusHeroSection extends StatefulWidget {
  const AboutusHeroSection({super.key});

  @override
  _AboutusHeroSection createState() => _AboutusHeroSection();
}

class _AboutusHeroSection extends State<AboutusHeroSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  // Note: Mark the 360 panorama image with '.360' suffix for logic
  final List<String> _images = ['assets/image_360.jpg'];

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

    final double height =
        isLargeScreen ? screenSize.height * 0.8 : screenSize.height * 0.6;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // PageView showing images or panorama
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final String img = _images[index];
              if (img.contains("_360") || img.contains(".360.")) {
                // Panorama Image - use Panorama widget for full 360°
                return Panorama(
                  sensorControl: SensorControl.None,
                  interactive: true,
                  longitude: 0,
                  latitude: 0,

                  // zoom: 1,
                  child: Image.asset(
                    'assets/image_360.jpg',
                    filterQuality: FilterQuality.high,
                  ),
                );
              } else {
                // Normal Image
                return Image.asset(
                  img,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  width: double.infinity,
                  height: double.infinity,
                );
              }
            },
          ),

          // Gradient overlay for better text visibility (doesn't block gestures)
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  stops: const [0.1, 0.5],
                ),
              ),
            ),
          ),

          // Page indicators at bottom center
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                return GestureDetector(
                  onTap:
                      () => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 4,
                    width: _currentPage == index ? 40 : 30,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index
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

  const _NavButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 30)),
      ),
    );
  }
}
