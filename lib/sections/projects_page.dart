import 'package:flutter/material.dart';

// ... existing code ...
class ProjectsPage extends StatefulWidget {
  final String initialCategory;
  
  const ProjectsPage({
    super.key,
    this.initialCategory = 'All',
  });

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

  // Simple arrays with just image paths
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
    'assets/residential/40.webp',
    'assets/residential/41.webp',
    'assets/residential/42.webp',
    'assets/residential/43.webp',
    'assets/residential/44.webp',
    'assets/residential/45.webp',

  ];

  final List<String> commercialImages = [
    'assets/residential/39.webp',
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
              children: ['All', 'Residential', 'Commercial'].map((category) {
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
                        ? Colors.blue[800] 
                        : Colors.green[800],
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