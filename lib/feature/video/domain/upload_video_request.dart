import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class VideoUpload {
  final String title;
  final String? description;
  final Uint8List videoData;
  final Uint8List thumbnailData;

  VideoUpload({
    required this.title,
    this.description,
    required this.videoData,
    required this.thumbnailData,
  });

  MultipartRequest setFormData(MultipartRequest request) => request
    ..fields['title'] = title
    ..fields['description'] = description ?? ''
    ..files.add(http.MultipartFile.fromBytes(
      'video_data',
      videoData,
      filename: 'video.mp4',
    ))
    ..files.add(http.MultipartFile.fromBytes(
      'thumbnail_data',
      thumbnailData,
      filename: 'thumbnail.jpg',
    ));
}
