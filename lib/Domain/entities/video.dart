class Video {
  final int id;
  final int roomId;
  final String videoUrl;
  final String previewUrl;
  final String size;
  final String duration;
  final int likesCount;
  final bool authLikeStatus;

  Video({
    required this.id,
    required this.roomId,
    required this.videoUrl,
    required this.previewUrl,
    required this.size,
    required this.duration,
    required this.likesCount,
    required this.authLikeStatus,
  });
}
