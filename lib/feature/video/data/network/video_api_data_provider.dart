import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_youtube_at_home/feature/video/domain/upload_video_request.dart';
import 'package:flutter_youtube_at_home/feature/video/data/repository/video_repository.dart';
import 'package:flutter_youtube_at_home/feature/video/domain/video.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoAPIDataProvider extends VideoProvider {
  final baseUrl = 'http://localhost:8080';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<List<Video>> getVideos() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) return [];
    try {
      final res = await http.get(Uri.parse('$baseUrl/api/video'), headers: {
        'Authorization': token,
      });
      if (res.statusCode == 200) {
        final decoder = jsonDecode(res.body);
        if (decoder['data'] != null && decoder['data']['videos'] != null) {
          final List<Video> videos = [];
          for (var video in decoder['data']['videos']) {
            // print(Video.fromJson(video).toString());
            videos.add(Video.fromJson(video));
          }
          // print(videos.toString());
          return videos;
        }
      } else
        throw Exception('Failed to load videos');
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
    return [];
    // return [
    //   Video(
    //       id: '1',
    //       title: 'First Video',
    //       description: 'This is the first video',
    //       thumbnailUrl:
    //           'https://uploads.dailydot.com/2018/10/olli-the-polite-cat.jpg?q=65&auto=format&w=1600&ar=2:1&fit=crop',
    //       videoUrl:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    // ];
  }

  @override
  Future<Uint8List> getFile(String id) async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) return Uint8List(0);
    try {
      final res = await http.get(Uri.parse('$baseUrl/$id'), headers: {
        'Authorization': token,
      });
      if (res.statusCode == 200) {
        // print('$res.body');
        print(res.headers['content-type']);
        // final file = res.bodyBytes;
        // print(file);
        // print(file.path);
        return res.bodyBytes;
        // return File(res.body);
      } else
        throw Exception('Failed to load videos');
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }

  @override
  Future<void> uploadVideo(VideoUpload requestData) async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) return;

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/video'))
      ..headers['Authorization'] = token;
    requestData.setFormData(request);

    try {
      var response = await request.send();
      if (response.statusCode == 201)
        print("Uploaded!");
      else
        throw Exception('Failed to upload video');
    } catch (e) {
      // print(e);
      throw Exception('Error uploading video: $e');
    }
  }
}
