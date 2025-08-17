import 'package:flutter/material.dart';

class ImageCarouselWithIndicators extends StatefulWidget {
  const ImageCarouselWithIndicators({super.key});

  @override
  State<ImageCarouselWithIndicators> createState() => _ImageCarouselWithIndicatorsState();
}

class _ImageCarouselWithIndicatorsState extends State<ImageCarouselWithIndicators> {
  final List<String> _images = [
    'https://picsum.photos/id/237/400/300',
    'https://picsum.photos/id/238/400/300',
    'https://picsum.photos/id/239/400/300',
  ];

  int _currentIndex = 0;
  Offset _startSwipeOffset = Offset.zero;

  void _goToNextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  void _goToPreviousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _images.length) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _goToNextImage,
          onHorizontalDragStart: (details) {
            _startSwipeOffset = details.localPosition;
          },
          onHorizontalDragEnd: (details) {
            if (_startSwipeOffset.dx < MediaQuery.of(context).size.width / 2) {
              _goToNextImage(); // swipe right to left
            } else {
              _goToPreviousImage(); // swipe left to right
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Image.network(
              _images[_currentIndex],
              key: ValueKey(_images[_currentIndex]),
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
