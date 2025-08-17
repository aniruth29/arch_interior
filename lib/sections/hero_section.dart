import 'dart:async';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _images = [
    'assets/modular_interior.webp',
    'assets/modular_kitchen.webp',
    'assets/modular_bedroom.webp',
    'assets/wardrobe.webp',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-cache images once the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final imgPath in _images) {
        precacheImage(AssetImage(imgPath), context);
      }
    });
    _startAutoSlide();
  }
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % _images.length;
        // Precache/await next image, then animate
        final image = AssetImage(_images[nextPage]);
        final completer = Completer();

        final listener = ImageStreamListener((_, __) {
          completer.complete();
        });

        final stream = image.resolve(const ImageConfiguration());
        stream.addListener(listener);

        completer.future.then((_) {
          if (mounted && _pageController.hasClients) {
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
          stream.removeListener(listener);
        });
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
      int prevPage = _currentPage > 0 ? _currentPage - 1 : _images.length - 1;
      _pageController.animateToPage(
        prevPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_pageController.hasClients) {
      int nextPage = (_currentPage + 1) % _images.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 1200;

    final double height = isLargeScreen
        ? screenSize.height * 0.8
        : screenSize.height * 0.6;
    final double buttonSize = isLargeScreen ? 60 : 40;
    final double horizontalPadding = isLargeScreen ? 40 : 20;
    final double topPosition = height * 0.5 - buttonSize / 2;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Carousel images, with optional decode hints for speed
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => Image.asset(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              cacheWidth: isLargeScreen ? 1920 : 900,
              cacheHeight: isLargeScreen ? 1080 : 600,
            ),
          ),

          // Gradient overlay for text visibility
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

          // Text Overlay (responsive position)
          Positioned(
            left: isLargeScreen ? screenSize.width * 0.1 : 40,
            bottom: height * 0.17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CREATING\nLASTING\nIMPRESSIONS\nTHROUGH',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    fontSize: isLargeScreen ? 32 : 22,
                    height: 1.2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'INTERIOR\nDESIGN',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: isLargeScreen ? 48 : 32,
                    height: 1.1,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Navigation Arrows (scale/hide if too small)
          if (height > buttonSize * 1.5 ) ...[
            Positioned(
              left: horizontalPadding,

              top: topPosition,
              child: _NavButton(
                icon: Icons.arrow_back_ios,
                onTap: _goToPrevious,
                size: buttonSize,
              ),
            ),
            Positioned(
              right: horizontalPadding,
              top: topPosition,
              child: _NavButton(
                icon: Icons.arrow_forward_ios,
                onTap: _goToNext,
                size: buttonSize,
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

// Navigation Arrow Widget
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const _NavButton({
    required this.icon,
    required this.onTap,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
