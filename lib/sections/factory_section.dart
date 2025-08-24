import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FactorySection extends StatefulWidget {
  const FactorySection({super.key});

  @override
  State<FactorySection> createState() => _FactorySectionState();
}

class _FactorySectionState extends State<FactorySection> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  bool _hasError = false;
  bool _isLoading = true;
  bool _isMuted = true; // Start muted by default

  @override
  void initState() {
    super.initState();
    print('FactorySection initialized');
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      print('Starting video initialization...');
      print('Video path: assets/videos/arch_aluminium_factory.mp4');

      _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/arch_aluminium_factory.mp4',
      );

      // Add listener for debugging
      _videoPlayerController!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

      print('Video controller created, initializing...');
      await _videoPlayerController!.initialize();
      print('Video initialized successfully');
      print('Video duration: ${_videoPlayerController!.value.duration}');
      print('Video size: ${_videoPlayerController!.value.size}');

      _videoPlayerController!.setLooping(true);
      print('Video looping set to true');

      // Set volume to 0 (muted) by default
      _videoPlayerController!.setVolume(0.0);
      print('Video muted by default');

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
          _isLoading = false;
        });
        // Start playing the video
        print('Starting video playback...');
        await _videoPlayerController!.play();
        print('Video playback started');
      }
    } catch (e) {
      print('Error initializing video: $e');
      print('Error details: ${e.toString()}');
      print('Error type: ${e.runtimeType}');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  void _toggleMute() {
    if (_videoPlayerController != null) {
      setState(() {
        _isMuted = !_isMuted;
        if (_isMuted) {
          _videoPlayerController!.setVolume(0.0);
        } else {
          _videoPlayerController!.setVolume(1.0);
        }
      });
      print('Video ${_isMuted ? 'muted' : 'unmuted'}');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    // Get screen dimensions for responsive sizing
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Determine screen type and set appropriate height
    double videoHeight;
    if (screenWidth < 600) {
      // Mobile: 35% of screen height
      videoHeight = screenHeight * 0.35;
    } else if (screenWidth < 1200) {
      // Tablet: 25% of screen width (current setting)
      videoHeight = screenWidth * 0.35;
    } else {
      // Large screen: 2x screen height
      videoHeight = screenHeight * 0.5;
    }

    if (_hasError) {
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
                  _initializeVideo();
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
                    image: AssetImage('assets/aluminium_factory.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
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
            if (_isVideoInitialized && _videoPlayerController != null)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoPlayerController!.value.size.width,
                    height: _videoPlayerController!.value.size.height,
                    child: VideoPlayer(_videoPlayerController!),
                  ),
                ),
              ),

            // Play/pause button
            if (_isVideoInitialized && _videoPlayerController != null)
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
                      _videoPlayerController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_videoPlayerController!.value.isPlaying) {
                          _videoPlayerController!.pause();
                        } else {
                          _videoPlayerController!.play();
                        }
                      });
                    },
                  ),
                ),
              ),

            // Mute/Unmute button
            if (_isVideoInitialized && _videoPlayerController != null)
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
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: _toggleMute,
                  ),
                ),
              ),

            // Video title overlay
            if (_isVideoInitialized)
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
                    'Arch Aluminium Factory Tour',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Video status indicator
            if (_isVideoInitialized && _videoPlayerController != null)
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
                    _videoPlayerController!.value.isPlaying ? '▶️' : '⏸️',
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
    final isMobile = screenSize.width < 600;

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
                        fontSize: isMobile ? 24 : 32,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  if (isMobile) // Mobile layout
                    Column(
                      children: [
                        _buildVideoPlayer(),
                        SizedBox(height: 30),
                        Text(
                          'Factory 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Main production facility with advanced machinery',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Take a virtual tour of our Arch Aluminium factory facilities',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        _buildVideoPlayer(),
                        SizedBox(height: 30),
                        Text(
                          'Factory 2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Secondary production facility',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Explore our wood factory facilities',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
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
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    'Factory 1',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Main production facility with advanced machinery',
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildVideoPlayer(),
                                  SizedBox(height: 8),
                                  Text(
                                    'Take a virtual tour of our Arch Aluminium factory facilities',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    'Factory 2',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Secondary production facility',
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildVideoPlayer(),
                                  SizedBox(height: 8),
                                  Text(
                                    'Explore our wood factory facilities',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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
