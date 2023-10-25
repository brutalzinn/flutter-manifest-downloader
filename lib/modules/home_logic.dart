import 'package:flutter/material.dart';
import 'package:manifest_downloader/core/widgets/progressbar/progress_bar_controller.dart';
import 'package:manifest_downloader/operations/operations.dart';

import 'home.dart';

class HomeLogic {
  final progressController = ProgressBarController();
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
    progressController.setFeedback("Verify..");
    await Operations.cleanupOutputDir(manifestFiles, outputDir, ignoreFolders.split(" "));
    progressController.setFeedback("Complete..");
  }
}
