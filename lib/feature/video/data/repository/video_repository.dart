import 'dart:typed_data';

import 'package:flutter_youtube_at_home/feature/video/domain/upload_video_request.dart';
import 'package:flutter_youtube_at_home/feature/video/domain/video.dart';

abstract class VideoProvider {
  Future<List<Video>> getVideos();
  Future<Uint8List> getFile(String id);
  Future<void> uploadVideo(VideoUpload requestData);
}

class VideoRepository {
  final VideoProvider videoProvider;

  VideoRepository({required this.videoProvider});

  Future<List<Video>> getVideos() async {
    return videoProvider.getVideos();
  }

  Future<Uint8List> getFile(String id) async {
    return videoProvider.getFile(id);
  }

  Future<void> uploadVideo(VideoUpload requestData) async {
    return videoProvider.uploadVideo(requestData);
  }
}
