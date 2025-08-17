import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String selectedCategory = 'All';

  final List<Map<String, String>> residentialProjects = List.generate(
    5,
    (index) => {
      'title': 'Residential Project ${index + 1}',
      'image': 'assets/room1.jpeg', // Replace with actual project images
    },
  );

  final List<Map<String, String>> commercialProjects = List.generate(
    5,
    (index) => {
      'title': 'Commercial Project ${index + 1}',
      'image': 'assets/room2.jpeg', // Replace with actual project images
    },
  );

  List<Map<String, String>> getFilteredProjects() {
    if (selectedCategory == 'All') {
      return [...residentialProjects, ...commercialProjects];
    } else if (selectedCategory == 'Residential') {
      return residentialProjects;
    } else {
      return commercialProjects;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects = getFilteredProjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Projects"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle Buttons
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
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Text(category),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Grid of Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
                children: filteredProjects.map((project) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(
                              project['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            project['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
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
