import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manifest_downloader/core/ui/widgets/custom_progress_bar.dart';
import 'package:manifest_downloader/modules/home/home.dart';
import 'package:window_manager/window_manager.dart';
import 'core/progress/progress_bar_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const defaultMain = ManifestDownloaderApp();
  await windowManager.ensureInitialized();
  WindowManager.instance.setMaximumSize(const Size(800, 800));
  runApp(defaultMain);
}

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
