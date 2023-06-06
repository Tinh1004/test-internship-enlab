import 'package:test_internship_enlab/modules/quizz/models/SaveQizz.dart';

class HistorySave{
  String time;
  SaveQizz resultYourQuizz;

  HistorySave({required this.time,required this.resultYourQuizz});

  @override
  String toString(){
    return "{time: ${time} - resultYourQuizz: ${resultYourQuizz}";
  }
}