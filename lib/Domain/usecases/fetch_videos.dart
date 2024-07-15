
import '../entities/video.dart';
import '../repositories/video_repository.dart';

class FetchVideos {
  final VideoRepository repository;

  FetchVideos(this.repository);

  Future<List<Video>> call(int page) async {
    return await repository.fetchVideos(page);
  }
}