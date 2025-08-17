import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'contact_section.dart';
import 'footer_section.dart';

import 'aboutus_header.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({super.key});

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection>
    with TickerProviderStateMixin {
  late AnimationController _titleSlideController;
  late Animation<Offset> _titleSlideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contactSectionKey = GlobalKey();
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();
    _titleSlideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleSlideController, curve: Curves.easeOutCubic),
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 950),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  void _startAnimation() {
    if (!_animationStarted) {
      _titleSlideController.forward();
      _fadeController.forward();
      _animationStarted = true;
    }
  }

  @override
  void dispose() {
    _titleSlideController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget bullet(String text, IconData icon, {Color? iconColor}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 21, color: iconColor ?? theme.colorScheme.primary),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 10),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text('Arch Interior'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // TODO: scroll to projects section if available
            },
            child: const Text('Our Projects', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              final context = _contactSectionKey.currentContext;
              if (context != null) {
                Scrollable.ensureVisible(
                  context,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: const Text('Contact Us', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.surface,
      body: VisibilityDetector(
        key: const Key('about-us-section'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.1) {
            _startAnimation();
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,

          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                const AboutusHeroSection(),

                  const SizedBox(height: 50,),
                  // === About Us Card ===
                  Container(


                    constraints: const BoxConstraints(maxWidth: 1200),
                    color: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.all(50),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 42),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SlideTransition(
                                      position: _titleSlideAnimation,
                                      child: Row(

                                        children: [
                                          Center(
                                            child: Text(
                                              "About Arch Interior",

                                              style: theme.textTheme.headlineMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: theme.colorScheme.primary,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                     " At Arch Interior, we believe great design is a powerful blend of functionality, elegance, and personal expression. Based in Chennai, we are a full-service interior design firm offering seamless end-to-end solutions—from initial consultation and space planning to material selection, custom furnishings, and flawless execution—all under one roof. Our passion lies in transforming homes, offices, and commercial spaces into inspiring environments that reflect your unique vision while enhancing everyday living. Whether modern minimalism, timeless classics, or bold contemporary styles, we craft spaces that balance beauty with purpose, ensuring every detail aligns with your lifestyle and aspirations.",
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              sectionHeader("What sets us apart"),
                                              bullet(
                                                  "We operate with an in-house factory ensuring quality and control over production.",
                                                  Icons.precision_manufacturing),
                                              bullet(
                                                  "Hands-on control enabling perfect execution.",
                                                  Icons.handyman_rounded),
                                              const SizedBox(height: 18),
                                              sectionHeader("Our team and approach"),
                                              Text(
                                                "Our experienced team utilizes modern tools",
                                                style: theme.textTheme.bodyLarge?.copyWith(
                                                  color: theme.colorScheme.onSurface,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              bullet("Layout planning", Icons.design_services),
                                              bullet("3D visualization", Icons.threed_rotation),
                                              bullet("Material selection", Icons.format_paint_rounded),
                                              bullet("Furniture making", Icons.chair_rounded),
                                              bullet("Final installation", Icons.workspace_premium),
                                              const SizedBox(height: 18),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 24),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: Image.asset(
                                                "assets/aboutus_image.webp", // Replace with your actual image path
                                                fit: BoxFit.cover,
                                                height: 400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                   Text("We specialize in residential, commercial, and turnkey interior projects, combining functionality with aesthetics to create spaces that are both beautiful and practical. Whether you're furnishing a home, designing an office, or launching a retail space, we deliver tailor-made solutions that reflect your personality and purpose",
                                     style: theme.textTheme.bodyLarge?.copyWith(
                                       color: theme.colorScheme.onSurface,
                                       fontWeight: FontWeight.w500,
                                       height: 1.5,
                                     ),
                                     textAlign: TextAlign.justify,),
                                    const SizedBox(height: 18),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.celebration,
                                          color: theme.colorScheme.onSurface.withOpacity(0.25),
                                          size: 24,
                                        ),
                                        const SizedBox(width: 7),
                                        Expanded(
                                          child: Text(
                                            "At Arch Interior, we don’t just design interiors, we create experiences.",
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 48),
                  const SizedBox(height: 48),
                  // ContactSection with GlobalKey for scrolling
                  ContactSection(key: _contactSectionKey),
                  const SizedBox(height: 48),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
