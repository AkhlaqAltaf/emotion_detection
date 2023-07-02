import 'package:emotion/screen/camera.dart';
import 'package:emotion/screen/videos.dart';
import 'package:flutter/material.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  var videos = [
    'assets/videos/Video1.mp4',
    'assets/videos/Video2.mp4',
    'assets/videos/Video3.mp4',
    'assets/videos/Video4.mp4',
    // 'assets/videos/Video5.mp4',
    // 'assets/videos/Video6.mp4',
    // 'assets/videos/Video7.mp4',
    // 'assets/videos/Video8.mp4',
    // 'assets/videos/Video9.mp4',
    // 'assets/videos/Video10.mp4',
    // 'assets/videos/Video11.mp4',
    // 'assets/videos/Video12.mp4',
    // 'assets/videos/Video13.mp4',
    // 'assets/videos/Video14.mp4',
    // 'assets/videos/Video15.mp4',
    // 'assets/videos/Video16.mp4',
    // 'assets/videos/Video17.mp4',
    // 'assets/videos/Video18.mp4',
    // 'assets/videos/Video19.mp4',
    // 'assets/videos/Video20.mp4',
    // 'assets/videos/Video21.mp4',
    // 'assets/videos/Video22.mp4',
    // 'assets/videos/Video23.mp4',
    // 'assets/videos/Video24.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 191, 189, 182)),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) => video(videos[index], index),
      ),
    );
  }

  Widget video(var video, int index) {
    return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPlayerWidget(video))),
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            decoration: BoxDecoration(
                color: const Color.fromARGB(222, 144, 144, 156),
                border: Border.all(color: Colors.black, width: 0.4)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    alignment: Alignment.center,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayerWidget(video),
                        )),
                    icon: const Icon(
                      Icons.movie,
                      size: 20,
                      color: Colors.black,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text("Video ${index + 1}  }"),
                )
              ],
            ),
          ),
        ));
  }
}
