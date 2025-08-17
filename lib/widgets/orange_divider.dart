import 'package:flutter/material.dart';

class OrangeDivider extends StatelessWidget {
  const OrangeDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      height: 2,
      width: 100,
      color: Colors.orange,
    );
  }
}
