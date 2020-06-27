class Result {
  String label;
  double confidence;

  Result({
    this.label,
    this.confidence,
  });

  factory Result.fromMap(Map data) {
    return Result(
      label: data['label'],
      confidence: data['confidence'],
    );
  }
}
