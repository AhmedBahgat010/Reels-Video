import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels/presentation/data/bloc/state.dart';

import '../../../Domain/entities/video.dart';
import '../../../Domain/usecases/fetch_videos.dart';

// Bloc
class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final FetchVideos fetchVideos;

  VideoBloc({required this.fetchVideos}) : super(VideoInitial()) {
    on<FetchVideosEvent>((event, emit) async {
      emit(VideoLoading());
      try {
        final videos = await fetchVideos(event.page);
        emit(VideoLoaded(videos: videos));
      } catch (e) {
        emit(VideoError(message: e.toString()));
      }
    });
  }
}