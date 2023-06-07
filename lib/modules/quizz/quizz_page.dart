import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_internship_enlab/common/widgets/button/main_button.dart';
import 'package:test_internship_enlab/common/widgets/button/second_button.dart';
import 'package:test_internship_enlab/data/repository.dart';
import 'package:test_internship_enlab/modules/home/bloc/home_cubit.dart';
import 'package:test_internship_enlab/modules/home/models/HistorySave.dart';
import 'package:test_internship_enlab/modules/quizz/bloc/quizz_cubit.dart';
import 'package:test_internship_enlab/modules/quizz/models/SaveQizz.dart';
import 'package:test_internship_enlab/modules/quizz/models/YourAnswer.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';
import 'package:test_internship_enlab/themes/styles_text.dart';
import 'package:test_internship_enlab/utils/app_images.dart';

import '../../models/Quizz.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.homeBloc}) : super(key: key);
  final HomeCubit homeBloc;

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  var bloc = QuizzCubit();
  var repo = Repository();

  @override
  void initState() {
    super.initState();
    print("init State");
    bloc.initData();
    bloc.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: bloc.indexQuizValueNotifier,
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
                    BlocConsumer(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is QuizzLoading || state is QuizzInitial) {
                          return _widgetTextMessage("Loading...");
                        }
                        if (state is QuizzGetDataSuccess) {
                          var listQizz = state.listData;
                          return Column(
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
                                    "/${bloc.listQizz.length}",
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
                              _widgetTextQuestion(listQizz[index].question ?? ""),
                              SizedBox(
                                height: 40.h,
                              ),
                              _widgetListAnswer(listQizz[index].allAnswer ?? []),
                              SizedBox(
                                height: 10.h,
                              ),
                              ValueListenableBuilder(
                                valueListenable: bloc.chooseAnswerValueNotifier,
                                builder: (context, value, child) {
                                  return MainButton(
                                    onPressed: () {
                                      value.isEmpty
                                          ? null
                                          : bloc.handleSaveAnswer();
                                      value.isEmpty
                                          ? null
                                          : index == (bloc.listQizz.length - 1)
                                              ? showSubmit()
                                              : bloc.onPessedNext();
                                    },
                                    height: 60.h,
                                    radius: 60.r,
                                    minWidth: 0.7.sw,
                                    title: index == (bloc.listQizz.length - 1)
                                        ? "submit"
                                        : "next",
                                    backgroundColor:
                                        value.isEmpty ? Colors.grey : Colors.red,
                                  );
                                },
                              )
                            ],
                          );
                        }
                        if (state is QuizzGetDataFailed) {
                          return _widgetTextMessage(state.errorMessage);
                        }
                        return _widgetTextMessage("....");
                      },
                      listener: (context, state) {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _widgetTextMessage(String message) {
    return Center(
      child: Text(
        message,
        style: StylesText.header1.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget _widgetTextQuestion(String question) {
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
      valueListenable: bloc.chooseAnswerValueNotifier,
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
    return SecondButton(
      onPressed: () {
        bloc.onPessedCheckedAnswer(answer);
      },
      answer: answer,
      isChecked: isChecked,
    );
  }

  showSubmit() {
    widget.homeBloc.addData(bloc.resultYourQuizz);
    bloc.onPessedSubmit();
        var score = bloc.resultYourQuizz.countCorrect /
        bloc.resultYourQuizz.listYourQuizz.length *
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
            "${bloc.resultYourQuizz.countCorrect}\\${bloc.resultYourQuizz.listYourQuizz.length} correct answer in ${bloc.seconds} seconds",
            style: StylesText.body3,
          ),
        ],
      );
    }

    return showModalBottomSheet(
      enableDrag: false,
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
                      Container(
                        height: 1.sh,
                        width: 1.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              image: AssetImage(AssetPNG.image2),
                              width: 0.5.sw,
                            ),
                            _widgetContent(),
                            MainButton(
                              onPressed: () {
                                bloc.onPessedPlayAgain();
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }
}
