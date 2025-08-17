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
    'assets/century_ply.webp',
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Our Clients',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 2,
            indent: 100,
            endIndent: 100,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _controller,
              // no itemCount for infinite scroll
              itemBuilder: (context, index) {
                final int actualIndex = index % clientImages.length;
                final diff = (_currentPage - index).abs();
                final scale = 0.9 + (1 - diff).clamp(0, 0.1);
                return Transform.scale(
                  scale: scale,
                  child: SizedBox(
                    width: 180,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 100,
                              child: Image.asset(
                                clientImages[actualIndex],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 12),
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
            indent: 100,
            endIndent: 100,
            color: Theme.of(context).disabledColor,
          ),
        ],
      ),
    );
  }
}
