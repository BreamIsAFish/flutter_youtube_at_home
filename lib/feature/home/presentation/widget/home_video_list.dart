import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/video/data/network/video_api_data_provider.dart';
import 'package:flutter_youtube_at_home/feature/video/data/repository/video_repository.dart';
import 'package:flutter_youtube_at_home/feature/video/domain/video.dart';
import 'package:flutter_youtube_at_home/feature/video/presentation/page/video_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeVideoList extends StatefulWidget {
  final _videoRepository =
      VideoRepository(videoProvider: VideoAPIDataProvider());

  HomeVideoList({super.key});

  @override
  State<HomeVideoList> createState() => _HomeVideoListState();
}

class _HomeVideoListState extends State<HomeVideoList> {
  List<Video> _videoList = [];
  late Future<List<VideoItem>> _videoItems;

  _handleClickVideo(VideoPlayerData data) {
    Navigator.pushNamed(context, '/video', arguments: VideoPageArguments(data));
  }

  @override
  void initState() {
    setState(() {
      _videoItems = fetchVideoList();
    });
    super.initState();
  }

  // getVid(String id) async {
  //   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await _prefs;
  //   final token = prefs.getString('token') ?? '';
  //   if (token.isEmpty) return File('');

  //   final res =
  //       await http.get(Uri.parse('http://localhost:8080/$id'), headers: {
  //     'Authorization': token,
  //   });
  //   if (res.statusCode == 200) {
  //     // print('$res.body');
  //     print(res.headers['content-type']);
  //     // final file = res.bodyBytes;
  //     // print(file);
  //     // print(file);
  //     // print(file.path);
  //     return res.bodyBytes;
  //     // return File(res.body);
  //   }
  // }

  Future<List<VideoItem>> fetchVideoList() async {
    _videoList = await widget._videoRepository.getVideos();
    List<VideoItem> _tempItems = [];
    // _videoList.forEach((video) async {
    //   print("video ${video.thumbnailUrl}");
    //   try {
    //     final File _image =
    //         await widget._videoRepository.getFile(video.thumbnailUrl);
    //     // print("image");
    //     _tempItems.add(VideoItem(
    //       id: video.id,
    //       title: video.title,
    //       description: video.description,
    //       thumbnail: _image,
    //     ));
    //     // print("item");
    //   } catch (err) {
    //     print("Error: $err");
    //   }
    //   // print(_image);
    // });
    for (var video in _videoList) {
      final Uint8List _image =
          await widget._videoRepository.getFile(video.thumbnailUrl);
      // Uint8List _image = await getVid(video.thumbnailUrl);
      // // Image.memory(_image);
      // print("image");
      _tempItems.add(VideoItem(
        id: video.id,
        title: video.title,
        description: video.description,
        thumbnail: _image,
      ));
    }
    return _tempItems;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<VideoItem>>(
      future: _videoItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final video = snapshot.data![index];
              final data = VideoPlayerData(
                  id: video.id,
                  title: video.title,
                  videoUrl:
                      'http://localhost:8080/${_videoList[index].videoUrl}',
                  uploaderId: _videoList[index].uploaderId);
              print("=-----------------=");
              // print(video.thumbnail.path);
              return ListTile(
                onTap: () => _handleClickVideo(data),
                title: Text(video.title),
                subtitle: Text(video.description ?? ''),
                // leading: Image.network(
                //     'http://localhost:8080/${_videoList[index].thumbnailUrl}'),
                leading: Image.memory(video.thumbnail),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load videos'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
