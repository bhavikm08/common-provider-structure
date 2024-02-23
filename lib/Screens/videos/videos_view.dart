import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideosView extends StatefulWidget {
  const VideosView({super.key});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {

  Future<List<File>> fetchLocalVideos() async {
    List<File> videoFiles = [];

    try {
      // Get the app's documents directory
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

      // Recursively list all files in the documents directory and subdirectories
      List<FileSystemEntity> files = _listFiles(appDocumentsDirectory);

      // Filter files to include only video files
      videoFiles = files.whereType<File>().toList();
    } catch (e) {
      print('Error fetching local videos: $e');
    }

    return videoFiles;
  }

  List<FileSystemEntity> _listFiles(Directory directory) {
    List<FileSystemEntity> files = [];

    try {
      List<FileSystemEntity> entities = directory.listSync();

      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          files.add(entity);
        } else if (entity is Directory) {
          files.addAll(_listFiles(entity));
        }
      }
    } catch (e) {
      print('Error listing files: $e');
    }

    return files;
  }


  void main1() async {
    List<File> localVideos = await fetchLocalVideos();
    for (File videoFile in localVideos) {
      print('Video file: ${videoFile.path}');
    }
  }



  @override
  void initState() {
    // _getFiles();
    main1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            main1();
          }, child: Text("press")),
        ],
      ),
    );
  }
}
