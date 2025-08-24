import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'factory_image_secttion.dart';

class FactorySection extends StatefulWidget {
  const FactorySection({super.key});

  @override
  State<FactorySection> createState() => _FactorySectionState();
}

class _FactorySectionState extends State<FactorySection> {
  VideoPlayerController? _aluminiumVideoController;
  VideoPlayerController? _woodVideoController;
  bool _isAluminiumVideoInitialized = false;
  bool _isWoodVideoInitialized = false;
  bool _hasAluminiumError = false;
  bool _hasWoodError = false;
  bool _isAluminiumLoading = true;
  bool _isWoodLoading = true;
  bool _isAluminiumMuted = true; // Start muted by default
  bool _isWoodMuted = true; // Start muted by default

  @override
  void initState() {
    super.initState();
    print('FactorySection initialized');
    _initializeVideos();
  }

  void _initializeVideos() async {
    try {
      setState(() {
        _isAluminiumLoading = true;
        _isWoodLoading = true;
        _hasAluminiumError = false;
        _hasWoodError = false;
      });

      // Initialize aluminium factory video
      _aluminiumVideoController = VideoPlayerController.asset(
        'assets/videos/arch_aluminium_factory.mp4',
      );

      // Initialize wood factory video
      _woodVideoController = VideoPlayerController.asset(
        'assets/videos/arch_wood_factory.mp4',
      );

      // Add listeners for debugging
      _aluminiumVideoController!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

      _woodVideoController!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

      // Initialize both videos
      await Future.wait([
        _aluminiumVideoController!.initialize(),
        _woodVideoController!.initialize(),
      ]);

      // Set looping for both videos
      _aluminiumVideoController!.setLooping(true);
      _woodVideoController!.setLooping(true);

      // Set volume to 0 (muted) by default for both videos
      _aluminiumVideoController!.setVolume(0.0);
      _woodVideoController!.setVolume(0.0);

      if (mounted) {
        setState(() {
          _isAluminiumVideoInitialized = true;
          _isWoodVideoInitialized = true;
          _isAluminiumLoading = false;
          _isWoodLoading = false;
        });
        // Start playing both videos
        await Future.wait([
          _aluminiumVideoController!.play(),
          _woodVideoController!.play(),
        ]);
      }
    } catch (e) {
      print('Error initializing videos: $e');
      if (mounted) {
        setState(() {
          _hasAluminiumError = true;
          _hasWoodError = true;
          _isAluminiumLoading = false;
          _isWoodLoading = false;
        });
      }
    }
  }

  void _toggleAluminiumMute() {
    if (_aluminiumVideoController != null) {
      setState(() {
        _isAluminiumMuted = !_isAluminiumMuted;
        if (_isAluminiumMuted) {
          _aluminiumVideoController!.setVolume(0.0);
        } else {
          _aluminiumVideoController!.setVolume(1.0);
        }
      });
      print('Aluminium video ${_isAluminiumMuted ? 'muted' : 'unmuted'}');
    }
  }

  void _toggleWoodMute() {
    if (_woodVideoController != null) {
      setState(() {
        _isWoodMuted = !_isWoodMuted;
        if (_isWoodMuted) {
          _woodVideoController!.setVolume(0.0);
        } else {
          _woodVideoController!.setVolume(1.0);
        }
      });
      print('Wood video ${_isWoodMuted ? 'muted' : 'unmuted'}');
    }
  }

  @override
  void dispose() {
    _aluminiumVideoController?.dispose();
    _woodVideoController?.dispose();
    super.dispose();
  }

  Widget _buildAluminiumVideoPlayer() {
    return _buildVideoPlayer(
      controller: _aluminiumVideoController,
      isInitialized: _isAluminiumVideoInitialized,
      hasError: _hasAluminiumError,
      isLoading: _isAluminiumLoading,
      isMuted: _isAluminiumMuted,
      onToggleMute: _toggleAluminiumMute,
      videoTitle: 'Arch Aluminium Factory Tour',
      fallbackImage: 'assets/aluminium_factory.webp',
    );
  }

  Widget _buildWoodVideoPlayer() {
    return _buildVideoPlayer(
      controller: _woodVideoController,
      isInitialized: _isWoodVideoInitialized,
      hasError: _hasWoodError,
      isLoading: _isWoodLoading,
      isMuted: _isWoodMuted,
      onToggleMute: _toggleWoodMute,
      videoTitle: 'Arch Wood Factory Tour',
      fallbackImage: 'assets/wooden_fact.JPG',
    );
  }

  Widget _buildVideoPlayer({
    required VideoPlayerController? controller,
    required bool isInitialized,
    required bool hasError,
    required bool isLoading,
    required bool isMuted,
    required VoidCallback onToggleMute,
    required String videoTitle,
    required String fallbackImage,
  }) {
    // Get screen dimensions for responsive sizing
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Determine screen type and set appropriate height
    double videoHeight;
    if (screenWidth < 600) {
      // Mobile: 35% of screen height
      videoHeight = screenHeight * 0.35;
    } else if (screenWidth < 1400) {
      // Tablet: 25% of screen width (current setting)
      videoHeight = screenWidth * 0.35;
    } else {
      // Large screen: 2x screen height
      videoHeight = screenHeight * 0.5;
    }

    if (hasError) {
      return Container(
        height: videoHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 40),
              SizedBox(height: 8),
              Text(
                'Failed to load video',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Check console for details',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print('Retrying video initialization...');
                  _initializeVideos();
                },
                child: Text('Retry'),
              ),
              SizedBox(height: 16),
              // Fallback to image
              Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(fallbackImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return Container(
        height: videoHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading video...'),
              SizedBox(height: 8),
              Text(
                'This may take a few seconds',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: videoHeight,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video player - full screen
            if (isInitialized && controller != null)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),

            // Play/pause button
            if (isInitialized && controller != null)
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Icon(
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      });
                    },
                  ),
                ),
              ),

            // Mute/Unmute button
            if (isInitialized && controller != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_off : Icons.volume_up,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: onToggleMute,
                  ),
                ),
              ),

            // Video title overlay
            if (isInitialized)
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    videoTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Video status indicator
            if (isInitialized && controller != null)
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    controller.value.isPlaying ? '▶️' : '⏸️',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    
    // Responsive breakpoints
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isLarge = screenWidth >= 1200;
    
    // Responsive sizes
    final titleFontSize = isMobile ? 24.0 : isTablet ? 32.0 : 40.0;
    final factoryTitleFontSize = isMobile ? 16.0 : isTablet ? 18.0 : 20.0;
    final descriptionFontSize = isMobile ? 12.0 : isTablet ? 14.0 : 16.0;
    final iconSize = isMobile ? 50.0 : isTablet ? 60.0 : 70.0;
    final iconContainerSize = isMobile ? 50.0 : isTablet ? 60.0 : 70.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 16.0,
          vertical: 20,
        ),
        child: Center(
          child: Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: screenSize.height * 1.5,
              width: screenSize.width * 0.95,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'Our Factories',
                                             style: Theme.of(
                         context,
                       ).textTheme.headlineMedium?.copyWith(
                         fontWeight: FontWeight.bold,
                         color: Theme.of(context).primaryColor,
                         fontSize: titleFontSize,
                       ),
                    ),
                  ),

                  SizedBox(height: 30),

                                                                                   if (isMobile) // Mobile layout
                       Column(
                         children: [
                           // Aluminium Factory Section - Clickable
                           InkWell(
                             borderRadius: BorderRadius.circular(20),
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => const FactoryImagePage(initialCategory: 'Aluminium Factory'),
                                 ),
                               );
                             },
                             child: Container(
                               padding: EdgeInsets.all(16),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withOpacity(0.1),
                                     blurRadius: 10,
                                     offset: Offset(0, 5),
                                   ),
                                 ],
                               ),
                               child: Column(
                                 children: [
                                   _buildAluminiumVideoPlayer(),
                                   SizedBox(height: 20),
                                   Text(
                                     'Aluminium Factory',
                                     style: TextStyle(
                                       fontSize: factoryTitleFontSize,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(height: 16),
                                   // Mobile icons grid (2x2)
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       // First row - Location and Area
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.location_on,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Location',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 16),
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.area_chart,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Area',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 16),
                                   // Second row - Machines and Workers
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.precision_manufacturing,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Machines',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 16),
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.people,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Workers',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 16),
                                   Text(
                                     'Main production facility with advanced machinery',
                                     style: TextStyle(fontSize: descriptionFontSize),
                                     textAlign: TextAlign.center,
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     'Take a virtual tour of our Arch Aluminium factory facilities',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize,
                                       fontStyle: FontStyle.italic,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     'Tap to view projects',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize * 0.8,
                                       color: Colors.orange,
                                       fontWeight: FontWeight.w600,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(height: 30),
                                                     // Wood Factory Section - Clickable
                           InkWell(
                             borderRadius: BorderRadius.circular(20),
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => const FactoryImagePage(initialCategory: 'Wooden Factory'),
                                 ),
                               );
                             },
                             child: Container(
                               padding: EdgeInsets.all(16),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withOpacity(0.1),
                                     blurRadius: 10,
                                     offset: Offset(0, 5),
                                   ),
                                 ],
                               ),
                               child: Column(
                                 children: [
                                   _buildWoodVideoPlayer(),
                                   SizedBox(height: 20),
                                   Text(
                                     'Wood Factory',
                                     style: TextStyle(
                                       fontSize: factoryTitleFontSize,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(height: 16),
                                   // Mobile icons grid for Wood Factory (2x2)
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       // First row - Location and Area
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.location_on,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Location',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 16),
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.area_chart,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Area',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 16),
                                   // Second row - Machines and Workers
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.precision_manufacturing,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Machines',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width: 16),
                                       Expanded(
                                         child: Column(
                                           children: [
                                             Container(
                                               width: iconContainerSize,
                                               height: iconContainerSize,
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Theme.of(context).primaryColor,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black.withOpacity(0.1),
                                                     blurRadius: 6,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                               ),
                                               child: Icon(
                                                 Icons.people,
                                                 color: Colors.white,
                                                 size: iconSize * 0.45,
                                               ),
                                             ),
                                             SizedBox(height: 8),
                                             Text(
                                               'Workers',
                                               style: TextStyle(
                                                 fontSize: descriptionFontSize,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 16),
                                   Text(
                                     'Secondary production facility',
                                     style: TextStyle(fontSize: descriptionFontSize),
                                     textAlign: TextAlign.center,
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     'Explore our wood factory facilities',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize,
                                       fontStyle: FontStyle.italic,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     'Tap to view projects',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize * 0.8,
                                       color: Colors.orange,
                                       fontWeight: FontWeight.w600,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       )
                  else // Desktop/tablet layout
                    Column(
                      children: [
                                                 Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                                                           Expanded(
                                flex: 2,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const FactoryImagePage(initialCategory: 'Aluminium Factory'),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Factory title at the top
                                        Text(
                                          'Aluminium Factory',
                                          style: TextStyle(
                                            fontSize: factoryTitleFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 16),
                                        // Grid of 4 circular icons (2x2)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // First row - Location and Area
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: iconContainerSize,
                                                    height: iconContainerSize,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                      size: iconSize * 0.45,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Location',
                                                    style: TextStyle(
                                                      fontSize: descriptionFontSize,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: iconContainerSize,
                                                    height: iconContainerSize,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.area_chart,
                                                      color: Colors.white,
                                                      size: iconSize * 0.45,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Area',
                                                    style: TextStyle(
                                                      fontSize: descriptionFontSize,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        // Second row - Machines and Workers
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: iconContainerSize,
                                                    height: iconContainerSize,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.precision_manufacturing,
                                                      color: Colors.white,
                                                      size: iconSize * 0.45,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Machines',
                                                    style: TextStyle(
                                                      fontSize: descriptionFontSize,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: iconContainerSize,
                                                    height: iconContainerSize,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.people,
                                                      color: Colors.white,
                                                      size: iconSize * 0.45,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Workers',
                                                    style: TextStyle(
                                                      fontSize: descriptionFontSize,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        // Factory description below
                                        Text(
                                          'Main production facility with advanced machinery',
                                          style: TextStyle(fontSize: descriptionFontSize),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Tap to view projects',
                                          style: TextStyle(
                                            fontSize: descriptionFontSize * 0.8,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                             SizedBox(width: 20),
                             Expanded(
                               flex: 3,
                               child: Column(
                                 children: [
                                   _buildAluminiumVideoPlayer(),
                                   SizedBox(height: 8),
                                   Text(
                                     'Take a virtual tour of our Arch Aluminium factory facilities',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize,
                                       fontStyle: FontStyle.italic,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                                                       SizedBox(height: 8),
                                    Text(
                                      'Tap to view projects',
                                      style: TextStyle(
                                        fontSize: descriptionFontSize * 0.8,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                           ],
                         ),
                        SizedBox(height: 50),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 2,
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                        ),
                          SizedBox(height: 50),

                      
                                                Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  _buildWoodVideoPlayer(),
                                  SizedBox(height: 8),
                                                                     Text(
                                     'Explore our wood factory facilities',
                                     style: TextStyle(
                                       fontSize: descriptionFontSize,
                                       fontStyle: FontStyle.italic,
                                     ),
                                     textAlign: TextAlign.center,
                                   ),
                                                                       SizedBox(height: 8),
                                    Text(
                                      'Tap to view projects',
                                      style: TextStyle(
                                        fontSize: descriptionFontSize * 0.8,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                 ],
                               ),
                             ),
                            SizedBox(width: 30),
                                                         Expanded(
                               flex: 2,
                               child: InkWell(
                                 borderRadius: BorderRadius.circular(20),
                                 onTap: () {
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => const FactoryImagePage(initialCategory: 'Wooden Factory'),
                                     ),
                                   );
                                 },
                                 child: Container(
                                   padding: EdgeInsets.all(20),
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20),
                                     boxShadow: [
                                       BoxShadow(
                                         color: Colors.black.withOpacity(0.1),
                                         blurRadius: 10,
                                         offset: Offset(0, 5),
                                       ),
                                     ],
                                   ),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       // Factory title at the top
                                       Text(
                                         'Wood Factory',
                                         style: TextStyle(
                                           fontSize: factoryTitleFontSize,
                                           fontWeight: FontWeight.bold,
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                       SizedBox(height: 16),
                                       // Grid of 4 circular icons (2x2)
                                       Row(
                                         children: [
                                           // First row - Location and Area
                                           Expanded(
                                             child: Column(
                                               children: [
                                                 Container(
                                                   width: 70,
                                                   height: 70,
                                                   decoration: BoxDecoration(
                                                     shape: BoxShape.circle,
                                                     color: Theme.of(context).primaryColor,
                                                     boxShadow: [
                                                       BoxShadow(
                                                         color: Colors.black.withOpacity(0.1),
                                                         blurRadius: 6,
                                                         offset: Offset(0, 3),
                                                       ),
                                                     ],
                                                   ),
                                                   child: Icon(
                                                     Icons.location_on,
                                                     color: Colors.white,
                                                     size: 32,
                                                   ),
                                                 ),
                                                 SizedBox(height: 8),
                                                 Text(
                                                   'Location',
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ],
                                             ),
                                           ),
                                           SizedBox(width: 16),
                                           Expanded(
                                             child: Column(
                                               children: [
                                                 Container(
                                                   width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.area_chart,
                                                      color: Colors.white,
                                                      size: 32,
                                                    ),
                                                  ),
                                                 SizedBox(height: 8),
                                                 Text(
                                                   'Area',
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 50),
                                       // Second row - Machines and Workers
                                       Row(
                                         children: [
                                           Expanded(
                                             child: Column(
                                               children: [
                                                 Container(
                                                   width: 70,
                                                   height: 70,
                                                   decoration: BoxDecoration(
                                                     shape: BoxShape.circle,
                                                     color: Theme.of(context).primaryColor,
                                                     boxShadow: [
                                                       BoxShadow(
                                                         color: Colors.black.withOpacity(0.1),
                                                         blurRadius: 6,
                                                         offset: Offset(0, 3),
                                                       ),
                                                     ],
                                                   ),
                                                   child: Icon(
                                                     Icons.precision_manufacturing,
                                                     color: Colors.white,
                                                     size: 32,
                                                   ),
                                                 ),
                                                 SizedBox(height: 8),
                                                 Text(
                                                   'Machines',
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ],
                                             ),
                                           ),
                                           SizedBox(width: 16),
                                           Expanded(
                                             child: Column(
                                               children: [
                                                 Container(
                                                   width: 70,
                                                   height: 70,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.people,
                                                      color: Colors.white,
                                                      size: 32,
                                                    ),
                                                  ),
                                                 SizedBox(height: 8),
                                                 Text(
                                                   'Workers',
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 16),
                                       // Factory description below
                                       Text(
                                         'Main production facility with advanced machinery',
                                         style: TextStyle(fontSize: descriptionFontSize),
                                         textAlign: TextAlign.center,
                                       ),
                                       SizedBox(height: 8),
                                       Text(
                                         'Tap to view projects',
                                         style: TextStyle(
                                           fontSize: descriptionFontSize * 0.8,
                                           color: Colors.orange,
                                           fontWeight: FontWeight.w600,
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),

                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

