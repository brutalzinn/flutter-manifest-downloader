import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manifest_downloader/core/widgets/progressbar/progress_bar.dart';
import 'package:manifest_downloader/modules/home.dart';

import 'core/widgets/progressbar/progress_bar_controller.dart';

void main() => runApp(const ManifestDownloaderApp());

class ManifestDownloaderApp extends StatelessWidget {
  const ManifestDownloaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
