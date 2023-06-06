import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:test_internship_enlab/data/repository.dart';
import 'package:test_internship_enlab/models/Quizz.dart';
import 'package:test_internship_enlab/modules/quizz/models/SaveQizz.dart';
import 'package:test_internship_enlab/modules/quizz/models/YourAnswer.dart';

part 'quizz_state.dart';

class QuizzCubit extends Cubit<QuizzState> {
  QuizzCubit() : super(QuizzInitial());
  var chooseAnswerValueNotifier = ValueNotifier("");
  var indexQuizValueNotifier = ValueNotifier(0);
  List<Quizz> listQizz = [];
  int seconds = 0;
  Timer? _timer;
  var resultYourQuizz = SaveQizz(countCorrect: 0, listYourQuizz: [], seconds: 0);

  var repo = Repository();

  Future<void> initData() async{
    try{
      getData();
    }catch(e){
      emit(QuizzGetDataFailed("Get data failed!!"));
    }
  }

  void getData() async {
    emit(QuizzLoading());
    var list = await repo.getData();
    listQizz = list;
    emit(QuizzGetDataSuccess(listQizz));
  }

  void handleSaveAnswer() {
    bool isCorrect = listQizz[indexQuizValueNotifier.value].correctAnswer ==
        chooseAnswerValueNotifier.value;
    var yourAnswer = YourAnswer(
        correctAnswer:
        listQizz[indexQuizValueNotifier.value].correctAnswer ?? '',
        allAnswer: listQizz[indexQuizValueNotifier.value].allAnswer ?? [],
        yourChoose: chooseAnswerValueNotifier.value,
        isCorrect: isCorrect,
        question: listQizz[indexQuizValueNotifier.value].question ?? '',
    );

    if (isCorrect) {
      resultYourQuizz.addCount();
    }
    resultYourQuizz.seconds = seconds;
    resultYourQuizz.addListQuizz(yourAnswer);

  }

  void onPessedCheckedAnswer(String value) {
    chooseAnswerValueNotifier.value = value;
  }


  void onPessedNext() {
    indexQuizValueNotifier.value = indexQuizValueNotifier.value + 1;
    chooseAnswerValueNotifier.value = "";
  }

  void onPessedSubmit() {
    chooseAnswerValueNotifier.value = "";
    indexQuizValueNotifier.value = 0;
    cancelTime();
  }

  void onPessedPlayAgain() {
    try{
      resultYourQuizz = SaveQizz(countCorrect: 0, listYourQuizz: [], seconds: 0);
      getData();
      startTimer();
    }catch(e){
      emit(QuizzGetDataFailed("Get data failed!!"));
    }
  }

  void startTimer() {
    seconds = 0;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      seconds++;
    });
  }

  void cancelTime() {
    _timer?.cancel();
  }

  String formatSeconds(int seconds) {
    int minutes = (seconds ~/ 60); // Calculate the minutes
    int remainingSeconds = seconds % 60; // Calculate the remaining seconds

    String minutesStr =
    minutes.toString().padLeft(2, '0'); // Ensure two-digit format
    String secondsStr =
    remainingSeconds.toString().padLeft(2, '0'); // Ensure two-digit format

    return '$minutesStr:$secondsStr';
  }

}
