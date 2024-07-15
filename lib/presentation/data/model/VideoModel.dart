
import '../../../Domain/entities/video.dart';

class VideoModel extends Video {
  VideoModel({
    required int id,
    required int roomId,
    required String videoUrl,
    required String previewUrl,
    required String size,
    required String duration,
    required int likesCount,
    required bool authLikeStatus,
  }) : super(
    id: id,
    roomId: roomId,
    videoUrl: videoUrl,
    previewUrl: previewUrl,
    size: size,
    duration: duration,
    likesCount: likesCount,
    authLikeStatus: authLikeStatus,
  );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      roomId: json['room_id'],
      videoUrl: json['video'],
      previewUrl: json['preview'],
      size: json['size'],
      duration: json['duration'],
      likesCount: json['likes_count'],
      authLikeStatus: json['auth_like_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'video': videoUrl,
      'preview': previewUrl,
      'size': size,
      'duration': duration,
      'likes_count': likesCount,
      'auth_like_status': authLikeStatus,
    };
  }
}
