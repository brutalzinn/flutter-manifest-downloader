import 'package:flutter/material.dart';

class ProgressBarController extends ChangeNotifier {
  double maxProgress = 0;
  double value = 0;
  void done() {
    value += 1;
    notifyListeners();
  }

  void setMaxProgress(int max) {
    max = max;
    notifyListeners();
  }
}
