import 'dart:io';
import 'dart:typed_data';

class Video {
  final String id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final String videoUrl;
  final String uploaderId;

  Video({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.uploaderId,
  });

  Video.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        thumbnailUrl = json['thumbnail_url'],
        videoUrl = json['url'],
        uploaderId = json['uploader_id'];
}

class VideoItem {
  final String id;
  final String title;
  final String? description;
  final Uint8List thumbnail;
  // final File video;

  VideoItem({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnail,
    // required this.video,
  });

  // VideoItem.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       thumbnailUrl = json['thumbnail_url'];
}

class VideoPlayerData {
  final String id;
  final String title;
  final String? description;
  final String videoUrl;
  final String uploaderId;

  // final File thumbnail;
  // final File video;

  VideoPlayerData({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    required this.uploaderId,
    // required this.video,
  });

  // VideoItem.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       thumbnailUrl = json['thumbnail_url'];
}
