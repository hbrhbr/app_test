import 'package:app_test/controller/movie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'custom_loader.dart';

class VideoPlayerWidget extends StatefulWidget {
  final int movieId;
  final void Function() onTrailerComplete;
  const VideoPlayerWidget({Key? key, required this.movieId, required this.onTrailerComplete}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;
  bool isFetchedList = false;

  @override
  void initState() {

    fetchVideosAndPlay();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !isFetchedList ? const CustomLoader(): YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {},
        onEnded: (a){
          if(playingIndex<videos.length){
            playingIndex++;
            _controller = YoutubePlayerController(
              initialVideoId: videos[playingIndex]['key'],
              flags: YoutubePlayerFlags(
                autoPlay: true,
                controlsVisibleAtStart: false,
                mute: false,
                captionLanguage: videos[playingIndex]['iso_639_1']??'en',
              ),
            );
            setState(() {});
          }else{
            widget.onTrailerComplete();
          }
        },
      )
    );
  }
  List videos = [];
  int playingIndex = 0;
  Future<void>fetchVideosAndPlay()async{
    MovieController movieController = Get.find<MovieController>();
    videos =  await movieController.fetchMovieVideos(movieId: widget.movieId);
    isFetchedList = true;
    setState(() {});
    _controller = YoutubePlayerController(
      initialVideoId: videos[playingIndex]['key'],
      flags: YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: false,
        mute: false,
        captionLanguage: videos[playingIndex]['iso_639_1']??'en',
      ),
    );
  }
}
