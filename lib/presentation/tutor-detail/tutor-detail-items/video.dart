import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatelessWidget {
  Video({super.key});

  final FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          controls: FlickLandscapeControls(),
          videoFit: BoxFit.contain,
          backgroundColor: Colors.black,
          aspectRatioWhenLoading: 16 / 9,
          iconThemeData: IconThemeData(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        flickVideoWithControlsFullscreen: FlickVideoWithControls(
          controls: FlickLandscapeControls(),
          videoFit: BoxFit.contain,
          backgroundColor: Colors.black,
          aspectRatioWhenLoading: 16 / 9,
          iconThemeData: IconThemeData(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
