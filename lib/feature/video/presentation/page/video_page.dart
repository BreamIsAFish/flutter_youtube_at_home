import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/video/domain/video.dart';
import 'package:flutter_youtube_at_home/feature/video/presentation/widget/video_player.dart';

class VideoPageArguments {
  final VideoPlayerData? data;
  VideoPageArguments(this.data);
}

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/home');
      });
      return Scaffold(
        body: Center(
          child: Text('No data'),
        ),
      );
    }

    final data = (args as VideoPageArguments).data;

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            VideoPlayer(url: data?.videoUrl ?? ''),
            Text(data?.title ?? ''),
            Text(data?.description ?? ''),
          ],
        ),
      ),
    );
  }
}
