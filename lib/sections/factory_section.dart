import 'package:flutter/material.dart';

class VisionMissionSection extends StatelessWidget {
  const VisionMissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final horizontalPadding = screenSize.width > 1000 ? screenSize.width * 0.1 : 32.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1600,
            maxHeight: screenSize.height * 0.9,
          ),
          child: SizedBox(
            width: screenSize.width * 0.95,
            child: Card(
              elevation: 10,
              color: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Heading
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Our Factories',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: isMobile ? 20 : 32,
                        ),
                      ),
                    ),

                    // Factory content
                    if (isMobile)
                      _buildHorizontalLayout(context, screenSize.width)
                    else
                      _buildVerticalLayout(context, screenSize),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, double screenWidth) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildFactoryCard(
              context: context,
              title: "Wooden Factory",
              description: "Inhouse Plywood Unit",
              location: "Pothur",
              area: "1000 Sq Feet",
              imagePath: 'assets/wooden_factory.webp',
              maxImageSize: screenWidth * 0.22,
            ),
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Theme.of(context).dividerColor,
            indent: 24,
            endIndent: 24,
          ),
          Expanded(
            child: _buildFactoryCard(
              context: context,
              title: "Aluminium Factory",
              description: "Aluminium Fabrication Unit",
              location: "Ambattur",
              area: "700 Sq Feet",
              imagePath: 'assets/aluminium_fact.webp',
              maxImageSize: screenWidth * 0.22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context, Size screenSize) {
    return Column(
      children: [
        _buildFactoryTile(
          context: context,
          title: "Wooden Factory",
          description: "Inhouse Plywood Unit",
          location: "Pothur",
          area: "1000 Sq Feet",
          imagePath: 'assets/wooden_factory.webp',
          maxImageSize: screenSize.width * 0.65,
          imageHeight: screenSize.height * 0.2,
        ),
        const SizedBox(height: 14),
        const Divider(thickness: 1),
        const SizedBox(height: 14),
        _buildFactoryTile(
          context: context,
          title: "Aluminium Factory",
          description: "Aluminium Fabrication Unit",
          location: "Ambattur",
          area: "700 Sq Feet",
          imagePath: 'assets/aluminium_fact.webp',
          maxImageSize: screenSize.width * 0.65,
          imageHeight: screenSize.height * 0.18,
        ),
      ],
    );
  }

  Widget _buildFactoryCard({
    required BuildContext context,
    required String title,
    required String description,
    required String location,
    required String area,
    required String imagePath,
    required double maxImageSize,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title clicked!')),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 12),
            _buildFactoryInfoText(
              context: context,
              title: title,
              description: description,
              location: location,
              area: area,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactoryTile({
    required BuildContext context,
    required String title,
    required String description,
    required String location,
    required String area,
    required String imagePath,
    required double maxImageSize,
    required double imageHeight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _buildFactoryInfoText(
              context: context,
              title: title,
              description: description,
              location: location,
              area: area,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: imageHeight,
            width: maxImageSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactoryInfoText({
    required BuildContext context,
    required String title,
    required String description,
    required String location,
    required String area,
    required double fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Location: $location",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontSize,
            ),
          ),
          Text(
            "Area: $area",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}