
import 'package:test_internship_enlab/modules/quizz/models/YourAnswer.dart';

class SaveQizz {
  int countCorrect;
  int seconds;
  List<YourAnswer> listYourQuizz;

  SaveQizz({required this.countCorrect, required this.listYourQuizz, required this.seconds});
  void addCount() {
    this.countCorrect = countCorrect + 1;
  }


  void addListQuizz(YourAnswer quizz) {
    listYourQuizz.add(quizz);
  }

  @override
  String toString() {
    return '{countCorrect: ${countCorrect} - listYourQuizz: ${listYourQuizz}}';
  }
}