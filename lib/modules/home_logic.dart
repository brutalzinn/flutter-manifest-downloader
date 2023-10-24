import 'package:manifest_downloader/core/widgets/progressbar/progress_bar_controller.dart';

import 'home.dart';

class HomeLogic {
  final progressController = ProgressBarController();
  Future<void> startSync(String manifestUrl, String outputDir) {
    
    
    progressController.value = 1;

    return Future.delayed(Duration.zero);
  }
}
