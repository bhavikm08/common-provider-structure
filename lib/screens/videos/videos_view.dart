import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideosView extends StatefulWidget {
  const VideosView({super.key});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {

  List<FileSystemEntity> _files = [];

  void _getFiles() async {
    final directory = await getExternalStorageDirectory();
    List<FileSystemEntity> files = directory!.listSync().where((entity) => entity.path.endsWith('.mp4')).toList();
    setState(() {
      _files = files;
    });
    print("Files :-> $_files");
  }
  @override
  void initState() {
    _getFiles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
