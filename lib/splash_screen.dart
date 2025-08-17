import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Alignment> _alignmentAnimation;

  late AnimationController _backgroundController;
  late Animation<double> _bgOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _alignmentAnimation = Tween<Alignment>(
      begin: Alignment.center,
      end: const Alignment(-1.0, -1.0),
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _bgOffsetAnimation = Tween<double>(begin: 0.0, end: -30.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    _logoController.forward();
    _backgroundController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedBuilder(
        animation: Listenable.merge([_logoController, _backgroundController]),
        builder: (context, child) {
          return Stack(
            children: [
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: OrangeAnimatedPainter(
                  offset: _bgOffsetAnimation.value,
                  bottomWaveColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Align(
                alignment: _alignmentAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Image.asset('assets/logo_bg.webp', height: 120),
                        ),
                      ),
                      const SizedBox(height: 16),


                      const SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OrangeAnimatedPainter extends CustomPainter {
  final double offset;
  final Color bottomWaveColor;

  OrangeAnimatedPainter({
    required this.offset,
    required this.bottomWaveColor,
  });



  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =bottomWaveColor;

    final topPath = Path()
      ..moveTo(0, size.height * 0.2 + offset)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.3 + offset,
        size.width,
        size.height * 0.1 + offset,
      )
      ..lineTo(size.width, 0 + offset)
      ..lineTo(0, 0 + offset)
      ..close();

    final bottomPath = Path()
      ..moveTo(0, size.height + offset)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.8 + offset,
        size.width,
        size.height * 0.95 + offset,
      )
      ..lineTo(size.width, size.height + offset)
      ..close();

    canvas.drawPath(topPath, paint);
    paint.color = bottomWaveColor;
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant OrangeAnimatedPainter oldDelegate) =>
      oldDelegate.offset != offset ||
      oldDelegate.bottomWaveColor != bottomWaveColor;
}
