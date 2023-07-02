// import 'package:emotion/screen/emotionDetector.dart';
import 'package:emotion/screen/camera.dart';
import 'package:emotion/screen/video_list.dart';

import 'package:flutter/material.dart';

class Navigationdrawer extends StatefulWidget {
  const Navigationdrawer({super.key});

  @override
  State<Navigationdrawer> createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  Widget bodyWidget = Text("Home");

  @override
  Widget build(BuildContext context) {
    final drawer_items = ListView(
      children: <Widget>[
        ListTile(
          title: const Text("Videos"),
          onTap: () {
            setState(() {
              bodyWidget = VideosList();
            });
          },
        ),
        ListTile(
            title: const Text("Emotion Detector"),
            onTap: () {
              setState(() {
                bodyWidget = EmotionDetectionPage();
              });
            })
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("App Bar"),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.4,
        child: drawer_items,
      ),
      body: bodyWidget,
    );
  }
}
