

import '../../../Domain/VideoService/videoService.dart';
import '../../../Domain/entities/video.dart';
import '../../../Domain/repositories/video_repository.dart';
import '../model/VideoModel.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoService service;

  VideoRepositoryImpl(this.service);

  @override
  Future<List<Video>> fetchVideos(int page) async {
    final videos = await service.fetchVideos(page);
    return videos.map((video) => VideoModel.fromJson(video)).toList();
  }
}
