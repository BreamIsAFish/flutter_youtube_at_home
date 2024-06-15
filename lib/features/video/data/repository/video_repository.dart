import 'package:flutter_youtube_at_home/features/video/domain/video.dart';

abstract class VideoProvider {
  Future<List<Video>> getVideos();
  // Future<Video> getVideo();
  Future<void> uploadVideo(Video video);
}

class VideoRepository {
  final VideoProvider videoProvider;

  VideoRepository({required this.videoProvider});

  Future<List<Video>> getVideos() async {
    return videoProvider.getVideos();
  }

  // Future<Video> getVideo() async {
  //   return videoProvider.getVideo();
  // }

  Future<void> uploadVideo(Video video) async {
    return videoProvider.uploadVideo(video);
  }
}
