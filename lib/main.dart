import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:video_poc/videoListItem.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String videoPath = '';

  void getVideoPath() async {
    print("HEEELELELOGOOGOXVOXFOX");
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      setState(() {
        this.videoPath = result.files.single.path;
      });
    }
    print('VIDEO PATH ${this.videoPath}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          cacheExtent: 10000.0,
          children: <Widget>[
            Text(
              'Video from Assets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            VideoListItem(
              videoPlayerController: VideoPlayerController.asset(
                'assets/videos/TurkeyHillGelato.mp4',
              ),
              looping: false,
            ),
            Text(
              'Video from the Internet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              'Valid Link',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            VideoListItem(
              videoPlayerController: VideoPlayerController.network(
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              ),
              looping: true,
            ),
            Text(
              'Invalid Link',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            VideoListItem(
              videoPlayerController: VideoPlayerController.network(
                // invalid URL to check whether error is bring displayed
                'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4',
              ),
              looping: false,
            ),
            Text(
              'Video from File Storage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            this.videoPath != ''
                ? Text(
                    'PATH: ${this.videoPath}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                : Text(
                    'PATH: -NA-',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
            this.videoPath != ''
                ? VideoListItem(
                    videoPlayerController: VideoPlayerController.file(
                      File(this.videoPath),
                    ),
                    looping: false,
                  )
                : Text(
                    'No video has been selected',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: getVideoPath,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
