import 'dart:io';
import 'package:flutter_youtube_at_home/feature/video/domain/upload_video_request.dart';
import 'package:universal_html/html.dart' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_at_home/feature/video/data/network/video_api_data_provider.dart';
import 'package:flutter_youtube_at_home/feature/video/data/repository/video_repository.dart';
import 'package:flutter_youtube_at_home/feature/video/presentation/widget/video_player.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final VideoRepository _videoRepository =
      VideoRepository(videoProvider: VideoAPIDataProvider());
  PlatformFile videoFile = PlatformFile(name: '', size: 0, bytes: Uint8List(0));
  Uint8List thumbnailFile = Uint8List(0);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String getVideoUrl(Uint8List data) {
    if (kIsWeb) {
      // is web (File.fromRawPath not support)
      final blob = html.Blob([data], 'video/mp4');
      return html.Url.createObjectUrlFromBlob(blob);
      // return File.fromUri(Uri.parse(url));
      // return ...
    } else {
      return File.fromRawPath(data).path;
    }
  }

  selectVideo() async {
    // upload video
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      // print(result.files.single);
      // File.fromRawPath(videoFile.bytes!);
      // print(getVideoUrl(result.files.single.bytes!));
      setState(() {
        videoFile = result.files.single!;
        // videoFile = File.fromRawPath(result.files.single.bytes!);
      });
    } else {
      print('User canceled the picker');
      // User canceled the picker
    }
  }

  selectThumbnail() async {
    // upload video
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      // print(result.files.single.bytes);
      setState(() {
        thumbnailFile = result.files.single.bytes!;
      });
    } else {
      print('User canceled the picker');
      // User canceled the picker
    }
  }

  onSubmit() async {
    // upload video
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        videoFile.bytes!.isEmpty ||
        thumbnailFile.isEmpty) {
      return;
    }
    try {
      await _videoRepository.uploadVideo(VideoUpload(
        title: _titleController.text,
        description: _descController.text,
        videoData: videoFile.bytes!,
        thumbnailData: thumbnailFile,
      ));
      Navigator.pushReplacementNamed(context, '/home');
      // print("submitting video");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // form with title, description, select video, select image and upload button
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Upload Form'),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: selectVideo,
                  child: Text('Select Video'),
                ),
                Text(videoFile.name),
                if (videoFile.bytes?.isNotEmpty ?? false)
                  VideoPlayer(
                    // type: "file",
                    height: 100,
                    autoPlay: false,
                    url: getVideoUrl(videoFile.bytes!),
                    // file: getVideoFile(videoFile.bytes!),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: selectThumbnail,
                  child: Text('Select Thumbnail'),
                ),
                // Text(thumbnailFile.path),
                if (thumbnailFile.isNotEmpty)
                  Image.memory(
                    thumbnailFile,
                    height: 150,
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Upload'),
            ),
          ),
        ],
      ),
    );
  }
}
