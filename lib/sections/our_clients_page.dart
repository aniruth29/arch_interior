import 'package:flutter/material.dart';

class OurClientsPage extends StatefulWidget {
  const OurClientsPage({super.key});

  @override
  State<OurClientsPage> createState() => _OurClientsPageState();
}

class _OurClientsPageState extends State<OurClientsPage> {
  final PageController _pageController = PageController(viewportFraction: 0.5);
  double _currentPage = 0.0;

  final List<IconData> clientIcons = [
    Icons.apartment,
    Icons.business_center,
    Icons.people_alt,
    Icons.settings,
    Icons.support_agent,
    Icons.travel_explore,
    Icons.handshake,
    Icons.corporate_fare,
    Icons.domain,
  ];

  final List<String> clientNames = [
    'Brakes India',
    'Ashok Leyland',
    'KM Associates',
    'OP Mobility',
    'Swanag Infra',
    'TVS Sundram',
    'Indocool',
    'TIDC India',
    'LR Interiors',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Clients'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Our Clients',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(
              thickness: 2, indent: 100, endIndent: 100, color: Colors.orange),
          const SizedBox(height: 30),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: clientIcons.length,
              itemBuilder: (context, index) {
                final scale = (_currentPage - index).abs();
                final isCenter = scale < 0.5;

                return TweenAnimationBuilder(
                  tween:
                      Tween<double>(begin: 1.0, end: isCenter ? 1.1 : 0.8),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isCenter
                              ? [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ]
                              : [],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                clientIcons[index],
                                size: 80,
                                color: Colors.orange,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                clientNames[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
