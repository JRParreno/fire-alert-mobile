// A widget that displays the picture taken by the user.
import 'dart:io';

import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPhoto extends StatelessWidget {
  final String imagePath;
  final bool isPreviewOnly;

  const PreviewPhoto({
    super.key,
    required this.imagePath,
    this.isPreviewOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(child: Image.file(File(imagePath))),
      floatingActionButton: isPreviewOnly
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: null,
              child: const Icon(Icons.chevron_left),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<MediaBloc>(context)
                      .add(AddCameraEvent(imagePath));
                  Navigator.pop(context);
                },
                heroTag: null,
                child: const Icon(Icons.check_circle_outline),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TakePictureScreen(),
                    ),
                  );
                },
                heroTag: null,
                child: const Icon(Icons.restart_alt),
              )
            ]),
    );
  }
}
