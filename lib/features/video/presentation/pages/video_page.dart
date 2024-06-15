import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/features/video/domain/video.dart';
import 'package:flutter_youtube_at_home/features/video/presentation/widgets/video_player.dart';

class VideoPageArguments {
  final Video video;

  VideoPageArguments(this.video);
}

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as VideoPageArguments;

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            VideoPlayer(url: args.video.videoUrl),
            Text(args.video.title),
            Text(args.video.description ?? ''),
          ],
        ),
      ),
    );
  }
}
