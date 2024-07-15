import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/entities/video.dart';
import '../data/bloc/state.dart';
import '../data/bloc/video_bloc.dart';
import '../widgets/reel_player.dart';

class ReelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reels')),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            return ReelsList(videos: state.videos);
          } else if (state is VideoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No videos found'));
          }
        },
      ),
    );
  }
}

class ReelsList extends StatelessWidget {
  final List<Video> videos;

  ReelsList({required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return ReelPlayer(video: videos[index]);
      },
    );
  }
}
