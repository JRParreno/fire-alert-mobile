// A widget that displays the picture taken by the user.
import 'dart:io';

import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPhoto extends StatelessWidget {
  final String imagePath;
  final String? imageUrl;

  final bool isPreviewOnly;

  const PreviewPhoto({
    super.key,
    required this.imagePath,
    this.imageUrl,
    this.isPreviewOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : Image.file(
                File(imagePath),
              ),
      ),
      floatingActionButton: isPreviewOnly
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: null,
              child: const Icon(Icons.chevron_left),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    if (imageUrl == null) {
                      BlocProvider.of<MediaBloc>(context)
                          .add(AddCameraEvent(imagePath));
                    }
                    Navigator.pop(context);
                  },
                  heroTag: null,
                  child: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (imageUrl == null) ...[
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
                ]
              ],
            ),
    );
  }
}
