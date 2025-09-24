import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onFactoryTab;

  const CustomAppBar({
    super.key,
    this.onAboutTap,
    this.onProjectsTap,
    this.onContactTap,
    this.onFactoryTab,
  });

  @override
  Widget build(BuildContext context) {
    // Obtain screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive values
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.015; // 1.5% of screen height
    final logoHeight = screenHeight * 0.05; // 5% of screen height

    return Material(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        color: Theme.of(context).colorScheme.onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo & Company Name
            Row(
              children: [
                SizedBox(
                  height: logoHeight,
                  child: Image.asset(
                    'assets/logo.webp',
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            ),

            // Navigation Buttons
            Row(
              children: [
                TextButton(
                  onPressed: onAboutTap ?? () {},
                  child: Text(
                    'About Us',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onFactoryTab ?? () {},
                  child: Text(
                    'Factory',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onProjectsTap ?? () {},
                  child: Text(
                    'Our Projects',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onContactTap ?? () {},
                  child: Text(
                    'Contact',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
