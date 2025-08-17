import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.outline, // Use surface variant or any app background variant
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Arch Interior',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,  // Theme primary color or accent
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: colorScheme.onPrimary),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildFooterItem(
                      context,
                      icon: Icons.phone,
                      title: 'Phone',
                      content: '+91 90032 12777\n+91 9941584255',
                    ),
                  ),
                  Expanded(
                    child: _buildFooterItem(
                      context,
                      icon: Icons.email,
                      title: 'Email',
                      content: 'www.archinterior.in\nenquiry@archinterior.in',
                    ),
                  ),
                  Expanded(
                    child: _buildFooterItem(
                      context,
                      icon: Icons.location_on,
                      title: 'Address',
                      content: 'No 122, Nainiammal St,\nKrishnapuram  Ambattur,\nChennai - 600053',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  '© 2025 Arch Interior. All rights reserved.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String content,
      }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary), // Use primary color for icons
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
