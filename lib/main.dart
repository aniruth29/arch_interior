import 'package:flutter/material.dart';
import 'theme.dart'; // Make sure this is the correct path
import 'util.dart';
import 'splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create text theme with custom fonts
    final textTheme = createTextTheme(context, "Poppins", "Poppins");

    // Initialize custom MaterialTheme
    final customTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Arch Interior',
      theme:
          customTheme
              .light(), // You can also use dark(), lightHighContrast() etc.
      home: const SplashScreen(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
