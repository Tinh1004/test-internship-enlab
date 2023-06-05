import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_internship_enlab/common/widgets/button/main_button.dart';
import 'package:test_internship_enlab/data/repository.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';
import 'package:test_internship_enlab/themes/styles_text.dart';
import 'package:test_internship_enlab/utils/app_images.dart';

import '../../models/Quizz.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class YourQuizz {
  String yourChoose;
  String correctAnswer;
  bool isCorrect;
  List<String> allQuestion;

  YourQuizz(
      {required this.yourChoose,
      required this.correctAnswer,
      required this.allQuestion,
      required this.isCorrect});
  @override
  String toString() {
    return '{yourChoose: ${yourChoose} - correctAnswer: ${correctAnswer} - isCorrect: ${isCorrect} }';
  }
}

class SaveQizz {
  int countCorrect = 0;
  List<YourQuizz> listYourQuizz;

  SaveQizz({required this.countCorrect, required this.listYourQuizz});
  void addCount() {
    this.countCorrect = countCorrect + 1;
  }

  void remove() {
    this.countCorrect = 0;
    listYourQuizz = [];
  }

  void addListQuizz(YourQuizz quizz) {
    listYourQuizz.add(quizz);
  }

  @override
  String toString() {
    return '{countCorrect: ${countCorrect} - listYourQuizz: ${listYourQuizz}}';
  }
}

class _QuizzPageState extends State<QuizzPage> {
  var chooseAnswerValueNotifier = ValueNotifier("");
  var indexQuizValueNotifier = ValueNotifier(0);
  var listQizz = [];
  var isLoading = true;
  var resultYourQuizz = SaveQizz(countCorrect: 0, listYourQuizz: []);
  int _seconds = 0;
  Timer? _timer;

  var repo = Repository();

  void getData() async {
    var list = await repo.getData();
    setState(() {
      listQizz = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print("init State");
    startTimer();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexQuizValueNotifier,
        builder: (context, index, child) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(color: AppColors.primary1),
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          onPressedNavigatePop();
                        },
                        child: Text(
                          "x",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  isLoading
                      ? Center(
                          child: Text(
                            "Loading...",
                            style: StylesText.header1
                                .copyWith(color: AppColors.white),
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Question ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "/${listQizz.length}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            _widgetQuestion(listQizz[index].question ?? ""),
                            SizedBox(
                              height: 40.h,
                            ),
                            _widgetListAnswer(listQizz[index].allAnswer ?? []),
                            SizedBox(
                              height: 10.h,
                            ),
                            ValueListenableBuilder(
                              valueListenable: chooseAnswerValueNotifier,
                              builder: (context, value, child) {
                                return MainButton(
                                  onPressed: () {
                                    handleSaveAnswer();
                                    value.isEmpty
                                        ? null
                                        : index == (listQizz.length - 1)
                                            ? onPessedSubmit()
                                            : onPessedNext();
                                  },
                                  height: 60.h,
                                  radius: 60.r,
                                  minWidth: 0.7.sw,
                                  title: index == (listQizz.length - 1)
                                      ? "submit"
                                      : "next",
                                  backgroundColor:
                                      value.isEmpty ? Colors.grey : Colors.red,
                                );
                              },
                            )
                          ],
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetQuestion(String question) {
    return Text(
      question,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
      maxLines: 40,
    );
  }

  Widget _widgetListAnswer(List<String> allQuestion) {
    return ValueListenableBuilder(
      valueListenable: chooseAnswerValueNotifier,
      builder: (context, value, child) {
        return Column(
          children: [
            for (String i in allQuestion)
              _widgetAnswer(answer: i, isChecked: i == value),
          ],
        );
      },
    );
  }

  Widget _widgetAnswer({required String answer, required bool isChecked}) {
    return InkWell(
      onTap: () {
        onPessedCheckedAnswer(answer);
      },
      child: Container(
        width: 1.sw,
        height: 50.h,
        margin: EdgeInsets.only(bottom: 12.h),
        padding:
            EdgeInsets.only(top: 10.r, bottom: 10.r, left: 16.r, right: 16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: AppColors.white, width: 2.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.6.sw,
              height: 1.sh,
              child: Text(
                answer,
                style: TextStyle(
                  color: isChecked ? Colors.red : Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              isChecked ? Icons.check_circle_outline : Icons.circle_outlined,
              size: 20.r,
              color: isChecked ? Colors.red : AppColors.white,
            ),
            // Icon(Icons.check_circle_outline, color: AppColors.white)
          ],
        ),
      ),
    );
  }

  void onPessedCheckedAnswer(String value) {
    chooseAnswerValueNotifier.value = value;
  }

  void handleSaveAnswer() {
    bool isCorrect = listQizz[indexQuizValueNotifier.value].correctAnswer ==
        chooseAnswerValueNotifier.value;
    var yourAnswer = YourQuizz(
        correctAnswer:
            listQizz[indexQuizValueNotifier.value].correctAnswer ?? '',
        allQuestion: listQizz[indexQuizValueNotifier.value].allAnswer ?? [],
        yourChoose: chooseAnswerValueNotifier.value,
        isCorrect: isCorrect);

    if (isCorrect) {
      resultYourQuizz.addCount();
    }
    resultYourQuizz.addListQuizz(yourAnswer);
  }

  void onPessedNext() {
    indexQuizValueNotifier.value = indexQuizValueNotifier.value + 1;
    chooseAnswerValueNotifier.value = "";
  }

  void onPessedSubmit() {
    chooseAnswerValueNotifier.value = "";
    indexQuizValueNotifier.value = 0;
    print('resultYourQuizz ${resultYourQuizz}');
    print('time ${formatSeconds(_seconds)}s');
    setState(() {
      isLoading = true;
    });
    cancelTime();
    showSubmit();
  }

  void showSubmit() {
    var score = resultYourQuizz.countCorrect /
        resultYourQuizz.listYourQuizz.length *
        100;
    Widget _widgetContent() {
      return Column(
        children: [
          Text(
            score >= 50 ? "Congratulation!" : "Completed!",
            style: StylesText.header1,
          ),
          SizedBox(
            height: 10.r,
          ),
          Text(
            score >= 50 ? "You are amazing!!" : "Better luck next time!",
            style: StylesText.body3,
          ),
          SizedBox(
            height: 6.r,
          ),
          Text(
            "${resultYourQuizz.countCorrect}\\${resultYourQuizz.listYourQuizz.length} correct answer in ${_seconds} seconds",
            style: StylesText.body3,
          ),
        ],
      );
    }

    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.all(15.r),
            child: Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 0.4.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 0.3.sh,
                          width: 1.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RotationTransition(
                                  turns: new AlwaysStoppedAnimation(-180 / 360),
                                  child: Image(
                                    image: AssetImage(AssetPNG.image1),
                                    width: 0.35.sw,
                                    height: 0.35.sw,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          height: 1.sh,
                          width: 1.sw,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 0.2.sw,
                                width: 0.2.sw,
                                child: DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: AppColors.accent1),
                                ),
                              ),
                              _widgetContent(),
                              MainButton(
                                onPressed: () {
                                  resultYourQuizz.remove();
                                  getData();
                                  startTimer();
                                  onPressedNavigatePop();
                                },
                                title: "Play again",
                                height: 50.h,
                                minWidth: 0.3.sw,
                                radius: 50.r,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }

  void startTimer() {
    _seconds = 0;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      _seconds++;
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
