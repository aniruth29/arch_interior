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
    _initializeVideos();
  }

  void _initializeVideos() async {
    setState(() {
      _isAluminiumLoading = true;
      _isWoodLoading = true;
      _hasAluminiumError = false;
      _hasWoodError = false;
    });

    try {
      _aluminiumVideoController = VideoPlayerController.asset(
        'assets/videos/arch_aluminium_factory.mp4',
      );
      _woodVideoController = VideoPlayerController.asset(
        'assets/videos/arch_wood_factory.mp4',
      );

      void setupController(VideoPlayerController controller) {
        controller.addListener(() {
          if (mounted) setState(() {});
        });
        controller.setLooping(true);
        controller.setVolume(0.0);
      }

      setupController(_aluminiumVideoController!);
      setupController(_woodVideoController!);

      await Future.wait([
        _aluminiumVideoController!.initialize(),
        _woodVideoController!.initialize(),
      ]);

      setState(() {
        _isAluminiumVideoInitialized = true;
        _isWoodVideoInitialized = true;
        _isAluminiumLoading = false;
        _isWoodLoading = false;
      });

      await Future.wait([
        _aluminiumVideoController!.play(),
        _woodVideoController!.play(),
      ]);
    } catch (e) {
      setState(() {
        _hasAluminiumError = true;
        _hasWoodError = true;
        _isAluminiumLoading = false;
        _isWoodLoading = false;
      });
    }
  }

  void _toggleMute(
      VideoPlayerController? controller,
      bool isMuted,
      Function(bool) setMute,
      ) {
    if (controller != null) {
      final newMute = !isMuted;
      setMute(newMute);
      controller.setVolume(newMute ? 0.0 : 1.0);
    }
  }

  void _toggleAluminiumMute() {
    _toggleMute(_aluminiumVideoController, _isAluminiumMuted, (val) {
      setState(() => _isAluminiumMuted = val);
    });
  }

  void _toggleWoodMute() {
    _toggleMute(_woodVideoController, _isWoodMuted, (val) {
      setState(() => _isWoodMuted = val);
    });
  }

  void _showFullScreenVideo(
      VideoPlayerController controller,
      String videoTitle,
      ) {
    // Store the current playback position and state
    final currentPosition = controller.value.position;
    final wasPlaying = controller.value.isPlaying;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
        final dialogWidth = screenSize.width * 0.9;
        final dialogHeight = screenSize.height * 0.8;

        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            child: Stack(
              children: [
                // Video container with padding
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),

                // Close button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 24),
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();

                        // Reinitialize the video player after a short delay
                        Future.delayed(Duration(milliseconds: 100), () {
                          if (mounted) {
                            setState(() {
                              // Reset the video player to its initial state
                              if (controller == _aluminiumVideoController) {
                                _isAluminiumVideoInitialized = false;
                                _isAluminiumLoading = true;
                              } else if (controller == _woodVideoController) {
                                _isWoodVideoInitialized = false;
                                _isWoodLoading = true;
                              }
                            });

                            // Reinitialize the specific video
                            _reinitializeVideo(controller);
                          }
                        });
                      },
                    ),
                  ),
                ),

                // Video title
                Positioned(
                  top: 16,
                  left: 16,
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

                // Play/Pause button
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 24,
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

                // Mute button
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.value.volume == 0.0
                            ? Icons.volume_off
                            : Icons.volume_up,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (controller.value.volume == 0.0) {
                            controller.setVolume(1.0);
                          } else {
                            controller.setVolume(0.0);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Helper method to reinitialize a specific video
  void _reinitializeVideo(VideoPlayerController controller) async {
    try {
      // Reinitialize the controller
      await controller.initialize();

      // Reset to beginning and play
      await controller.seekTo(Duration.zero);
      await controller.play();
      controller.setVolume(0.0); // Mute by default

      // Update the state
      if (mounted) {
        setState(() {
          if (controller == _aluminiumVideoController) {
            _isAluminiumVideoInitialized = true;
            _isAluminiumLoading = false;
            _isAluminiumMuted = true;
          } else if (controller == _woodVideoController) {
            _isWoodVideoInitialized = true;
            _isWoodLoading = false;
            _isWoodMuted = true;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          if (controller == _aluminiumVideoController) {
            _hasAluminiumError = true;
            _isAluminiumLoading = false;
          } else if (controller == _woodVideoController) {
            _hasWoodError = true;
            _isWoodLoading = false;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _aluminiumVideoController?.dispose();
    _woodVideoController?.dispose();
    super.dispose();
  }

  Widget buildIconColumn(
      IconData icon,
      String label,
      double iconSize,
      double fontSize,
      ) {
    return Column(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
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
          child: Icon(icon, color: Colors.white, size: iconSize * 0.45),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    double videoHeight;
    if (screenWidth < 600) {
      videoHeight = screenHeight * 0.35;
    } else if (screenWidth < 1400) {
      videoHeight = screenWidth * 0.5;
    } else {
      videoHeight = screenHeight * 0.5;
    }

    if (hasError) {
      return Container(
        height: videoHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey,
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
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initializeVideos,
                child: Text('Retry'),
              ),
              SizedBox(height: 16),
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
          color: Colors.grey,
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
                style: TextStyle(fontSize: 12, color: Colors.grey),
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
        color: Colors.grey,
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

            // Play/Pause button
            if (isInitialized && controller != null)
              Positioned(
                bottom: 20,
                right: isMobile ? 120 : 130,
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
             SizedBox(width: 10,),

            // Full-screen button
            if (isInitialized && controller != null)
              Positioned(
                bottom: 20,
                right: isMobile ? 20 : 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: IconButton(
                    icon: Icon(Icons.fullscreen, size: 35, color: Colors.white),
                    onPressed: () {
                      _showFullScreenVideo(controller, videoTitle);
                    },
                  ),
                ),
              ),

            // Mute button
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

            // Video title
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

            // Play status indicator
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isMobile = screenWidth < 900;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isLarge = screenWidth >= 1200;

    final titleFontSize =
    isMobile
        ? 24.0
        : isTablet
        ? 32.0
        : 40.0;
    final factoryTitleFontSize =
    isMobile
        ? 16.0
        : isTablet
        ? 18.0
        : 20.0;
    final descriptionFontSize =
    isMobile
        ? 12.0
        : isTablet
        ? 14.0
        : 16.0;
    final iconSize =
    isMobile
        ? 50.0
        : isTablet
        ? 60.0
        : 70.0;
    final iconContainerSize = iconSize;

    double videoHeight;
    if (screenWidth < 600) {
      videoHeight = screenHeight * 0.35;
    } else if (screenWidth < 1400) {
      videoHeight = screenWidth * 0.5;
    } else {
      videoHeight = screenHeight * 0.5;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
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
                if (isMobile)
                  Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const FactoryImagePage(
                                initialCategory: 'Aluminium Factory',
                              ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.location_on,
                                      'Location : Thirumulaivoyil \nAmbattur',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.area_chart,
                                      'Area: 2500sqft',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.precision_manufacturing,
                                      'Advanced Machines',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.people,
                                      '20 + Workers',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Main production facility with advanced machinery',
                                style: TextStyle(
                                  fontSize: descriptionFontSize,
                                ),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const FactoryImagePage(
                                initialCategory: 'Wooden Factory',
                              ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.location_on,
                                      'Location : Pothur,Redhills',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.area_chart,
                                      'Area:5000 sqft',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.precision_manufacturing,
                                      'Plywood Processing Unit',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: buildIconColumn(
                                      Icons.people,
                                      '35 + Workers',
                                      iconContainerSize,
                                      descriptionFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Secondary production facility',
                                style: TextStyle(
                                  fontSize: descriptionFontSize,
                                ),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                else
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
                                    builder:
                                        (context) => const FactoryImagePage(
                                      initialCategory:
                                      'Aluminium Factory',
                                    ),
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Aluminium Factory',
                                      style: TextStyle(
                                        fontSize: factoryTitleFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.location_on,
                                            'Location : Thirumulaivoyil \nAmbattur',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.area_chart,
                                            'Area : 2500 sqft',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.precision_manufacturing,
                                            'Advanced Machines',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.people,
                                            '20 + Workers',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Main production facility with advanced machinery',
                                      style: TextStyle(
                                        fontSize: descriptionFontSize,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8),
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
                                    builder:
                                        (context) => const FactoryImagePage(
                                      initialCategory: 'Wooden Factory',
                                    ),
                                  ),
                                );
                              },
                              child: Center(

                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Wood Factory',
                                      style: TextStyle(
                                        fontSize: factoryTitleFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.location_on,
                                            'Location : Pothur,Redhills',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.area_chart,
                                            'Area: 5000 sqft',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.precision_manufacturing,
                                            'Plywood Processing Unit',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: buildIconColumn(
                                            Icons.people,
                                            '35 + Workers',
                                            iconContainerSize,
                                            descriptionFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Main production facility with advanced machinery',
                                      style: TextStyle(
                                        fontSize: descriptionFontSize,
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
    );
  }
}