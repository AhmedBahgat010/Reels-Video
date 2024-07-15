import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels/presentation/Screens/reels_page.dart';
import 'package:reels/presentation/data/bloc/state.dart';
import 'package:reels/presentation/data/bloc/video_bloc.dart';
import 'package:reels/presentation/data/repositories/video_repository_impl.dart';

import 'Domain/VideoService/videoService.dart';
import 'Domain/usecases/fetch_videos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => VideoBloc(
          fetchVideos: FetchVideos(VideoRepositoryImpl(VideoService())),
        )..add(FetchVideosEvent(page: 1)),
        child: ReelsPage(),
      ),
    );
  }
}