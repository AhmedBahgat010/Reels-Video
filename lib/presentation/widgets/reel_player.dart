import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../../Domain/entities/video.dart';

const kReelCacheKey = "reelsCacheKey";
final kCacheManager = CacheManager(
  Config(
    kReelCacheKey,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
    repo: JsonCacheInfoRepository(databaseName: kReelCacheKey),
    fileService: HttpFileService(),
  ),
);

class ReelPlayer extends StatefulWidget {
  final Video video;

  const ReelPlayer({Key? key, required this.video}) : super(key: key);

  @override
  _ReelPlayerState createState() => _ReelPlayerState();
}

class _ReelPlayerState extends State<ReelPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _videoInitialized = false;
  bool _showPlayPauseIcon = false;
  Timer? _hideIconTimer;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  Future<void> initializeController() async {
    var fileInfo = await kCacheManager.getFileFromCache(widget.video.videoUrl);
    if (fileInfo == null) {
      await kCacheManager.downloadFile(widget.video.videoUrl);
      fileInfo = await kCacheManager.getFileFromCache(widget.video.videoUrl);
    }
    if (mounted) {
      _controller = VideoPlayerController.file(fileInfo!.file)
        ..initialize().then((_) {
          setState(() {
            _controller.setLooping(true);
            _controller.play();
            _isPlaying = true;
            _videoInitialized = true;
          });
        });
      _controller.addListener(() {
        if (_controller.value.isPlaying && !_isPlaying) {
          setState(() {
            _isPlaying = true;
          });
        } else if (!_controller.value.isPlaying && _isPlaying) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideIconTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
    _showIconTemporarily();
  }

  void _showIconTemporarily() {
    setState(() {
      _showPlayPauseIcon = true;
    });
    _hideIconTimer?.cancel();
    _hideIconTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        _showPlayPauseIcon = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _videoInitialized
        ? GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed Bahgat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      widget.video.likesCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.white),
                      onPressed: () {
                        // Handle like action
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.white),
                      onPressed: () {
                        // Handle comment action
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Handle share action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Visibility(
              visible: _showPlayPauseIcon,
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
