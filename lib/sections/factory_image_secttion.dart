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
   "assets/aluminium_factory/1d6dc1f9-bc63-4643-9002-c5d1524420ac.webp",
    "assets/aluminium_factory/fc1b8636-9054-4e0e-9d48-86b3b6727e86.webp",
    "assets/aluminium_factory/4512145e-c6d0-4174-a476-3b23650cf89f.webp",
    "assets/aluminium_factory/1d6dc1f9-bc63-4643-9002-c5d1524420ac.webp",
    "assets/aluminium_factory/9f104f22-0d80-4165-9bbc-d738ec9c49d4.webp",
  ];

  final List<String> aluminiumFactoryImages = [
   "assets/wooden_factory/IMG_0133.webp",
    "assets/wooden_factory/IMG_0134.webp",
    "assets/wooden_factory/IMG_0140.webp",
    "assets/wooden_factory/IMG_0136.webp"
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
        title: const Text("Our Factories"),
        backgroundColor: Theme.of(context).primaryColor,
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
                          isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
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