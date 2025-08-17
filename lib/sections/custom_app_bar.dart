import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const CustomAppBar({
    super.key,
    this.onAboutTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        color: Theme.of(context).colorScheme.onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo & Company Name
            Row(
              children: [
                SizedBox(

                  child: Image.asset('assets/logo.webp',filterQuality: FilterQuality.high,),
                  height:40 ,
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

