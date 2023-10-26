class Progress {
  String? file;
  String? feedback;
  bool? running;
  double value;

  Progress({
    this.file,
    this.feedback,
    this.running,
    this.value = 0,
  });

  void setFeedback(String msg) {
    feedback = msg;
  }
}
