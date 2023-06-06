class YourAnswer {
  String yourChoose;
  String correctAnswer;
  String question;
  bool isCorrect;
  List<String> allAnswer;

  YourAnswer({
    required this.yourChoose,
    required this.correctAnswer,
    required this.question,
    required this.allAnswer,
    required this.isCorrect,
  });
  @override
  String toString() {
    return '{yourChoose: ${yourChoose} - correctAnswer: ${correctAnswer} - isCorrect: ${isCorrect} - allAnswer: ${allAnswer} }';
  }
}
