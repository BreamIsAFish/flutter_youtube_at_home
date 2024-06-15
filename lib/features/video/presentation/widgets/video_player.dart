import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as vp;

class VideoPlayer extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final bool autoPlay;
  final Function? onEnd;

  const VideoPlayer({
    super.key,
    required this.url,
    this.width = 300,
    this.height = 300,
    this.autoPlay = true,
    this.onEnd,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late vp.VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = vp.VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          widget.autoPlay ? _controller.play() : _controller.pause();
        });

        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            widget.onEnd?.call();
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: vp.VideoPlayer(_controller),
                )
              : Container(),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
