import 'package:manifest_downloader/core/widgets/progressbar/progress_bar_controller.dart';
import 'package:manifest_downloader/operations/operations.dart';

import 'home.dart';

class HomeLogic {
  final progressController = ProgressBarController();
  Future<void> startSync(String manifestUrl, String outputDir, String ignoreFolders) async {
    final manifestFiles = await Operations.readManifestFiles(manifestUrl);
    progressController.setMaxProgress(manifestFiles.length);

    await Future.wait(manifestFiles.map((item) async {
      await Operations.downloadFile(item, outputDir);
      progressController.done();
    }));

    await Operations.cleanupOutputDir(manifestFiles, outputDir, ignoreFolders.split(" "));
    return Future.delayed(Duration.zero);
  }
}
