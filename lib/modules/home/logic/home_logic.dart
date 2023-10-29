import 'package:flutter/material.dart';
import 'package:manifest_downloader/core/managers/config/models/config_model.dart';
import 'package:manifest_downloader/core/progress/progress.dart';
import 'package:manifest_downloader/core/progress/progress_bar_controller.dart';
import 'package:manifest_downloader/operations/operations.dart';

import '../../../core/managers/config/config_manager.dart';

class HomeLogic {
  final progressController = ProgressBarController();

  Future<ConfigModel> loadConfig() async {
    var result = await ConfigManager.loadConfig();
    return result;
  }

  Future<void> saveConfig(ConfigModel config) async {
    await ConfigManager.saveConfig(config);
  }

  Future<void> startSync(
      String manifestUrl, String outputDir, String ignoreFolders) async {
    final manifestFiles = await Operations.readManifestFiles(manifestUrl);
    final quantityManifestFiles = manifestFiles.length;
    progressController.setMaxProgress(quantityManifestFiles);
    await Future.wait(manifestFiles.map((item) async {
      progressController.setFeedback("Downloading.. ${item.name}");
      await Operations.downloadFile(item, outputDir);
      progressController.done();
    }));
    progressController.reset();
    progressController.setMaxProgress(quantityManifestFiles);
    progressController.setFeedback("start files verify..");
    final toIgnoreFolders = ignoreFolders.split(" ");
    await Operations.cleanupOutputDir(manifestFiles, outputDir, toIgnoreFolders,
        (Progress progress) {
      progressController.setFeedback(progress.feedback ?? "");
      progressController.done();
    });
    progressController.setFeedback("ready to play.");
  }
}
