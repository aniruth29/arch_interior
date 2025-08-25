// ... existing code ...
import 'package:flutter/material.dart';
import 'projects_page.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Breakpoints
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;
    final bool isLargeScreen = screenWidth >= 1200;

    // Responsive card height
    final double cardHeight = isMobile
        ? screenHeight * 0.9
        : (isTablet ? screenHeight * 0.75 : screenHeight * 0.75);

    // Responsive icon size and gap
    final double iconSize = isMobile
        ? screenWidth * 0.05
        : (isTablet ? screenWidth * 0.03 : screenWidth * 0.03);

    double responsiveFont(double large, double medium, double small) {
      if (isMobile) return small;
      if (isTablet) return medium;
      return large;
    }

    MainAxisAlignment iconRowAlignment =
    (isTablet || isLargeScreen) ? MainAxisAlignment.center : MainAxisAlignment.start;

    void navigateToProjects(BuildContext context, String category) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectsPage(initialCategory: category),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 40.0,
        vertical: isMobile ? 30 : 60,
      ),
      child: Center(
        child: Card(
          elevation: 12,
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
          child: SizedBox(
            height: cardHeight,
            width: isMobile ? screenWidth * 0.98 : screenWidth * 0.95,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Heading
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 24),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'What We Offer',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: responsiveFont(38, 30, 22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: isMobile
                        ? Column( // Mobile layout - vertical
                      children: [
                        // Residential Section
                        Expanded(
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            onTap: () => navigateToProjects(context, 'Residential'),
                            child: Container(
                              padding: EdgeInsets.all(isMobile ? 16 : 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    'Residential',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                      fontSize: responsiveFont(26, 22, 18),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  Center(
                                    child: Image.asset(
                                      'assets/home.webp',
                                      height: screenHeight *
                                          (isMobile ? 0.08 : 0.125),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(thickness: 1, color: Colors.orange),
                                  const SizedBox(height: 10),
                                  // Icon Rows
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.king_bed_outlined, 'Bedroom', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.kitchen_outlined, 'Kitchen', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.bathtub_outlined, 'Bath', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.chair, 'Living', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.curtains_outlined, 'Curtains', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.light, 'Lighting', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_florist_outlined, 'Plants', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.table_bar_outlined, 'Dining', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.balcony_outlined, 'Balcony', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(thickness: 2, height: 15, color: Theme.of(context).disabledColor),
                        // Commercial Section
                        Expanded(
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            onTap: () => navigateToProjects(context, 'Commercial'),
                            child: Container(
                              padding: EdgeInsets.all(isMobile ? 16 : 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    'Commercial',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                      fontSize: responsiveFont(26, 22, 18),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  Image.asset(
                                    'assets/commerical.webp',
                                    height: screenHeight *
                                        (isMobile ? 0.08 : 0.125),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(thickness: 1, color: Colors.deepOrange),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.storefront_outlined, 'Store', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.chair_alt, 'Office Chair', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.meeting_room_outlined, 'Cabin', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_cafe_outlined, 'Cafeteria', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.curtains_outlined, 'Curtains', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.light, 'Lighting', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_florist_outlined, 'Plants', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.tv_outlined, 'TV', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.table_restaurant, 'Desk', iconSize, Colors.deepOrange, responsiveFont(13, 11, 10)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Row( // Tablet/Desktop layout - horizontal
                      children: [
                        // Residential Section
                        Expanded(
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            onTap: () => navigateToProjects(context, 'Residential'),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    'Residential',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                      fontSize: responsiveFont(26, 22, 14),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  Center(
                                    child: Image.asset(
                                      'assets/home.webp',
                                      height: screenHeight * 0.125,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(thickness: 1, color: Colors.orange),
                                  const SizedBox(height: 20),
                                  // Icon Rows
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.king_bed_outlined, 'Bedroom', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.kitchen_outlined, 'Kitchen', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.bathtub_outlined, 'Bath', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.chair, 'Living', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.curtains_outlined, 'Curtains', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.light, 'Lighting', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_florist_outlined, 'Plants', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.table_bar_outlined, 'Dining', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.balcony_outlined, 'Balcony', iconSize, Theme.of(context).colorScheme.primary, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(thickness: 2, width: 15, color: Theme.of(context).disabledColor),
                        // Commercial Section
                        Expanded(
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            onTap: () => navigateToProjects(context, 'Commercial'),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    'Commercial',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                      fontSize: responsiveFont(26, 22, 14),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  Image.asset(
                                    'assets/commerical.webp',
                                    height: screenHeight * 0.125,
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(thickness: 1, color: Colors.deepOrange),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.storefront_outlined, 'Store', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.chair_alt, 'Office Chair', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.meeting_room_outlined, 'Cabin', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_cafe_outlined, 'Cafeteria', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.curtains_outlined, 'Curtains', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.light, 'Lighting', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: iconRowAlignment,
                                    children: [
                                      Expanded(
                                        child: _iconLabel(Icons.local_florist_outlined, 'Plants', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.tv_outlined, 'TV', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                      Expanded(
                                        child: _iconLabel(Icons.table_restaurant, 'Desk', iconSize, Colors.deepOrange, responsiveFont(13, 11, 9)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget Method
  Widget _iconLabel(
      IconData icon,
      String label,
      double size,
      Color color,
      double fontSize,
      ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size, color: color),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}