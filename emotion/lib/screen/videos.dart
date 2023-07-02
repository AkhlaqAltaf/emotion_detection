import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:emotion/screen/camera.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String video;

  VideoPlayerWidget(this.video);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  late Future<void> initializer;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.video);
    initializer = controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.purple,
            child: FutureBuilder(
              future: initializer,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_isPlaying) {
                    controller.play();
                  } else {
                    controller.pause();
                  }
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text("Video"),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    if (_isPlaying) {
                      controller.play();
                    } else {
                      controller.pause();
                    }
                  });
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            child: EmotionDetectionPage(),
          ),
        ],
      ),
    );
  }
}
