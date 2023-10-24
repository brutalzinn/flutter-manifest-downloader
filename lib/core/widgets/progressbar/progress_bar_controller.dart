import 'package:flutter/material.dart';

class ProgressBarController extends ChangeNotifier {
  int maxProgress = 0;
  int value = 0;
  void done() {
    value += 1;
    notifyListeners();
  }

  void setMaxProgress(int max) {
    max = max;
    notifyListeners();
  }
}
