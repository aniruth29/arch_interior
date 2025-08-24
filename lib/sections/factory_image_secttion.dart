import 'package:flutter/material.dart';

class FactoryImagePage extends StatefulWidget {
  final String initialCategory;
  
  const FactoryImagePage({
    Key? key, 
    this.initialCategory = 'All',
  }) : super(key: key);

  @override
  State<FactoryImagePage> createState() => _FactoryImagePageState();
}

class _FactoryImagePageState extends State<FactoryImagePage> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  // Simple arrays with just image paths
  final List<String> woodenFactoryImages = [
    'assets/room.webp',
    'assets/room1.webp',
    'assets/room1,1.webp',
    'assets/room1,2.webp',
    'assets/room2,1.webp',
    'assets/room2,2.webp',
    'assets/modular_bedroom.webp',
    'assets/modular_interior.webp',
  ];

  final List<String> aluminiumFactoryImages = [
    'assets/office.webp',
    'assets/commerical.webp',
    'assets/construction.webp',
    'assets/indocool.webp',
    'assets/km.png',
    'assets/ashok_leyland_logo.webp',
    'assets/brakes_india.webp',
    'assets/century_ply.png',
  ];

  List<String> getFilteredImages() {
    if (selectedCategory == 'All') {
      return [...woodenFactoryImages, ...aluminiumFactoryImages];
    } else if (selectedCategory == 'Wooden Factory') {
      return woodenFactoryImages;
    } else {
      return aluminiumFactoryImages;
    }
  }

  void navigateToCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    
    // Scroll to top when category changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredImages = getFilteredImages();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Projects"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle Buttons with navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['All', 'Wooden Factory', 'Aluminium Factory'].map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSelected ? Colors.orange : Colors.grey[300],
                      foregroundColor:
                          isSelected ? Colors.white : Colors.black,
                      elevation: isSelected ? 4 : 1,
                    ),
                    onPressed: () {
                      navigateToCategory(category);
                    },
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedCategory == 'Wooden Factory' 
                      ? Colors.brown.withOpacity(0.1) 
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedCategory == 'Wooden Factory' 
                        ? Colors.brown.withOpacity(0.3) 
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  '${selectedCategory} Projects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: selectedCategory == 'Wooden Factory' 
                        ? Colors.brown[800] 
                        : Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (selectedCategory != 'All') SizedBox(height: 16),
            // Grid of Images
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
                children: filteredImages.map((imagePath) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}