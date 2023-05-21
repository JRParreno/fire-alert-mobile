import 'dart:io';

import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class PreviewVideo extends StatefulWidget {
  final String filePath;
  final bool isPreviewOnly;

  const PreviewVideo({
    Key? key,
    required this.filePath,
    this.isPreviewOnly = false,
  }) : super(key: key);

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: widget.isPreviewOnly
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    BlocProvider.of<MediaBloc>(context)
                        .add(AddVideoEvent(widget.filePath));
                    Navigator.pop(context);
                  },
                )
              ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}
