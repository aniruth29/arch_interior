import 'package:flutter/material.dart';
import 'sections/hero_section.dart';
import 'sections/about_us_section.dart';
import 'sections/portfolio_section.dart';
import 'sections/factory_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'sections/custom_app_bar.dart';
import 'sections/projects_page.dart'; // <-- This is important
import 'sections/clients_section.dart'; // Adjust path if your file is elsewhere
//import 'sections/carousel_indicator.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToContact() {
    final context = _contactKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToAboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutUsSection()), // Your distinct page
    );
  }

  void _navigateToProjects() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProjectsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            CustomAppBar(
              onAboutTap: _navigateToAboutUs,
              onProjectsTap: _navigateToProjects,
              onContactTap: _scrollToContact,
            ),
            // Your other sections here...
            const HeroSection(),
            const PortfolioSection(),
            const ClientsSection(),
            const FactorySection(),
            ContactSection(key: _contactKey),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
