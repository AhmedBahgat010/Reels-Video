// Events
import '../../../Domain/entities/video.dart';
// Events
abstract class VideoEvent {}

class FetchVideosEvent extends VideoEvent {
  final int page;

  FetchVideosEvent({required this.page});
}

// States
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Video> videos;

  VideoLoaded({required this.videos});
}

class VideoError extends VideoState {
  final String message;

  VideoError({required this.message});
}