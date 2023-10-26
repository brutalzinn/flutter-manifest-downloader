import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:manifest_downloader/core/utils.dart';

import 'progress.dart';

class ProgressBarController extends ChangeNotifier {
  num maxProgress = 0;
  late Progress progress;

  ProgressBarController() {
    progress = Progress();
  }

  void done() {
    progress.value += Utils.remapper(progress.value + 0.1, 0, maxProgress, 0, 1);
    notifyListeners();
  }

  void reset() {
    maxProgress = 0;
    progress.feedback = "";
    progress.value = 0;
    notifyListeners();
  }

  void setMaxProgress(num max) {
    maxProgress = max;
    notifyListeners();
  }

  void setFeedback(String msg) {
    progress.feedback = msg;
    notifyListeners();
  }
}
