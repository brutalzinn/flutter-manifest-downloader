import 'package:flutter/material.dart';
import 'package:manifest_downloader/core/progress/progress.dart';
import 'package:manifest_downloader/core/progress/progress_bar_controller.dart';
import 'package:manifest_downloader/operations/operations.dart';

import '../core/config/models/config.dart';
import 'home.dart';

class HomeLogic {
  final progressController = ProgressBarController();

  Future<Config> loadConfig() async {
    var result = await Config.loadConfig();
    return result;
  }

  Future<void> saveConfig(Config config) async {
    await config.saveConfig();
  }

  Future<void> startSync(String manifestUrl, String outputDir, String ignoreFolders) async {
    final manifestFiles = await Operations.readManifestFiles(manifestUrl);
    final quantityManifestFiles = manifestFiles.length;
    progressController.setMaxProgress(quantityManifestFiles);
    await Future.wait(manifestFiles.map((item) async {
      await Operations.downloadFile(item, outputDir);
      progressController.setFeedback("Downloading.. ${item.name}");
      progressController.done();
    }));
    progressController.reset();
    progressController.setMaxProgress(quantityManifestFiles);
    progressController.setFeedback("start files verify..");
    final toIgnoreFolders = ignoreFolders.split(" ");
    await Operations.cleanupOutputDir(manifestFiles, outputDir, toIgnoreFolders, (Progress progress) {
      progressController.setFeedback(progress.feedback ?? "");
    });
    progressController.setFeedback("ready to play.");
  }
}
