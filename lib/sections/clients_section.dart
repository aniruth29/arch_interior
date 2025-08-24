import 'dart:async';
import 'package:flutter/material.dart';

class ClientsSection extends StatefulWidget {
  const ClientsSection({super.key});

  @override
  State<ClientsSection> createState() => _ClientsSectionState();
}

class _ClientsSectionState extends State<ClientsSection> {
  final int _initialPage = 1000;
  late final PageController _controller;
  double _currentPage = 1000.0;
  Timer? _timer;

  final List<String> clientImages = [
    'assets/brakes_india.webp',
    'assets/ashok_leyland_logo.webp',
    'assets/km.png',
    'assets/opmobility.png',
    'assets/swanag.webp',
    'assets/sundaram.webp',
    'assets/indocool.webp',
    'assets/century_ply.png',
    'assets/rks.webp',
    'assets/tidc.webp'
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.33,
    );
    _currentPage = _initialPage.toDouble();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? _currentPage;
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_controller.hasClients) {
        final nextPage = _controller.page!.toInt() + 1;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Breakpoints for responsive design
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Responsive values
    final double sectionHeight = isMobile
        ? screenHeight * 0.2  // Reduced height for mobile
        : (isTablet ? screenHeight * 0.25 : screenHeight * 0.3);

    final double viewportFraction = isMobile
        ? 0.5
        : (isTablet ? 0.4 : 0.4);

    final double itemWidth = isMobile
        ? screenWidth * 0.4
        : (isTablet ? screenWidth * 0.4 : screenWidth * 0.3 );

    final double itemHeight = isMobile
        ? screenHeight * 0.14  // Reduced card height for mobile
        : (isTablet ? screenHeight * 0.18 : screenHeight * 0.25);

    final double imageHeight = isMobile
        ? screenHeight * 0.06 // Reduced image height for mobile
        : (isTablet ? screenHeight * 0.08 :  screenHeight * 0.2);

    final double dividerIndent = isMobile
        ? screenWidth * 0.1
        : 100;

    final double horizontalPadding = isMobile
        ? 16.0
        : 24.0;

    final double titleFontSize = isMobile
        ? 24.0
        : (isTablet ? 28.0 : 32.0);

    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        children: [
          Text(
            'Our Clients',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 2,
            indent: dividerIndent,
            endIndent: dividerIndent,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 20), // Reduced spacing for mobile
          SizedBox(
            height: sectionHeight,
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (context, index) {
                final int actualIndex = index % clientImages.length;
                final diff = (_currentPage - index).abs();
                final scale = 0.9 + (1 - diff).clamp(0, 0.1);
                return Transform.scale(
                  scale: scale,
                  child: SizedBox(
                    width: itemWidth,
                    height: itemHeight, // Added explicit height constraint
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: isMobile ? 4 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).disabledColor,
                            blurRadius: 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 8.0 : 16.0), // Reduced padding for mobile
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: itemWidth * 0.8,
                              height: imageHeight,
                              child: Image.asset(
                                clientImages[actualIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: isMobile ? 4 : 8), // Reduced spacing for mobile
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 2,
            indent: dividerIndent,
            endIndent: dividerIndent,
            color: Theme.of(context).disabledColor,
          ),
        ],
      ),
    );
  }
}