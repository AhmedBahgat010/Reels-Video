import 'package:dio/dio.dart';

class VideoService {
  static const String apiUrl = 'https://api.sawalef.app/api/v1/reels';
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchVideos(int page) async {
    try {
      final response = await _dio.get('$apiUrl?page=$page');
      final data = response.data;
      final List videosJson = data['data'];
      return videosJson;
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }
}