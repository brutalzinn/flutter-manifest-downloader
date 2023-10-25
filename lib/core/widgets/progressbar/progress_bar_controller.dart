import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manifest_downloader/core/utils.dart';

class ProgressBarController extends ChangeNotifier {
  num maxProgress = 0;
  double value = 0;
  String feedback = "";

  void done() {
    value += Utils.remapper(value + 0.1, 0, maxProgress, 0, 1);
    notifyListeners();
  }

  void reset() {
    maxProgress = 0;
    feedback = "";
    value = 0;
    notifyListeners();
  }

  void setMaxProgress(num max) {
    maxProgress = max;
    notifyListeners();
  }

  void setFeedback(String msg) {
    feedback = msg;
    notifyListeners();
  }
}
