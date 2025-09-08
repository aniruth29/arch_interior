import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  final String initialCategory;

  const ProjectsPage({super.key, this.initialCategory = 'All'});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  // Your local asset images
  final List<String> residentialImages = [
    'assets/residential/1.webp',
    'assets/residential/2.webp',
    'assets/residential/3.webp',
    'assets/residential/4.webp',
    'assets/residential/5.webp',
    'assets/residential/6.webp',
    'assets/residential/7.webp',
    'assets/residential/8.webp',
    'assets/residential/9.webp',
    'assets/residential/10.webp',
    'assets/residential/11.webp',
    'assets/residential/12.webp',
    'assets/residential/13.webp',
    'assets/residential/14.webp',
    'assets/residential/15.webp',
    'assets/residential/16.webp',
    'assets/residential/17.webp',
    'assets/residential/18.webp',
    'assets/residential/19.webp',
    'assets/residential/20.webp',
    'assets/residential/21.webp',
    'assets/residential/22.webp',
    'assets/residential/23.webp',
    'assets/residential/24.webp',
    'assets/residential/25.webp',
    'assets/residential/26.webp',
    'assets/residential/27.webp',
    'assets/residential/28.webp',
    'assets/residential/29.webp',
    'assets/residential/30.webp',
    'assets/residential/31.webp',
    'assets/residential/32.webp',
    'assets/residential/33.webp',
    'assets/residential/34.webp',
    'assets/residential/35.webp',
    'assets/residential/36.webp',
    'assets/residential/37.webp',
    'assets/residential/38.webp',
    'assets/residential/39.webp',
  ];

  final List<String> commercialImages = [
    'assets/residential/40.webp',
    'assets/residential/41.webp',
    'assets/residential/42.webp',
    'assets/residential/43.webp',
    'assets/residential/44.webp',
    'assets/residential/45.webp',
  ];

  List<String> getFilteredImages() {
    if (selectedCategory == 'All') {
      return [...residentialImages, ...commercialImages];
    } else if (selectedCategory == 'Residential') {
      return residentialImages;
    } else {
      return commercialImages;
    }
  }

  void navigateToCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // Function to determine number of columns based on screen width
  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      return 5;
    } else if (screenWidth > 900) {
      return 4;
    } else if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }

  // Define the animation type for each image deterministically
  int getAnimationTypeForImage(int index) {
    return index % 6; // 6 different animation types
  }

  @override
  Widget build(BuildContext context) {
    final filteredImages = getFilteredImages();
    final crossAxisCount = getCrossAxisCount(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Projects"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle Buttons with even width
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['All', 'Residential', 'Commercial'].map((category) {
                final isSelected = selectedCategory == category;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isSelected ? Colors.orange : Colors.grey,
                        foregroundColor:
                        isSelected ? Colors.white : Colors.black,
                        elevation: isSelected ? 4 : 1,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        navigateToCategory(category);
                      },
                      child: Text(
                        category,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Category Header
            if (selectedCategory != 'All')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedCategory == 'Residential'
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedCategory == 'Residential'
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.green.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  '${selectedCategory} Projects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: selectedCategory == 'Residential'
                        ? Colors.blue
                        : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (selectedCategory != 'All') const SizedBox(height: 16),
            // Grid of Images with responsive columns
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: filteredImages.length,
                itemBuilder: (context, index) {
                  final animationType = getAnimationTypeForImage(index);
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _HoverEffectImage(
                        imagePath: filteredImages[index],
                        animationType: animationType,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverEffectImage extends StatefulWidget {
  final String imagePath;
  final int animationType;

  const _HoverEffectImage({
    required this.imagePath,
    required this.animationType,
  });

  @override
  _HoverEffectImageState createState() => _HoverEffectImageState();
}

class _HoverEffectImageState extends State<_HoverEffectImage>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });

    if (hovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildHoverEffect() {
    switch (widget.animationType) {
      case 0: // Zoom with overlay
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildOverlayContent(),
          ),
        );
      case 1: // Slide from bottom
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(_controller),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildOverlayContent(),
          ),
        );
      case 2: // Slide from top
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(_controller),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildOverlayContent(),
          ),
        );
      case 3: // Slide from left
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(_controller),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildOverlayContent(),
          ),
        );
      case 4: // Slide from right
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(_controller),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildOverlayContent(),
          ),
        );
      case 5: // Fade with scale
        return FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: _buildOverlayContent(),
          ),
        );
      default:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: _buildOverlayContent(),
        );
    }
  }

  Widget _buildOverlayContent() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(
            Icons.zoom_in,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image with zoom effect on hover
          ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Image not found',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Hover effect overlay
          _buildHoverEffect(),
        ],
      ),
    );
  }
}