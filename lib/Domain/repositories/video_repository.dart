
import '../entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> fetchVideos(int page);
}
