// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'media_bloc.dart';

abstract class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object?> get props => [];
}

class MediaLoaded extends MediaState {
  final String? imagePath;
  final String? videoPath;

  const MediaLoaded({
    this.imagePath,
    this.videoPath,
  });

  MediaLoaded copyWith({
    String? imagePath,
    String? videoPath,
  }) {
    return MediaLoaded(
      imagePath: imagePath ?? this.imagePath,
      videoPath: videoPath ?? this.videoPath,
    );
  }

  @override
  List<Object?> get props => [imagePath, videoPath];
}
