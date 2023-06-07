import 'package:flutter/material.dart';
import 'package:test_internship_enlab/common/widgets/button/second_button.dart';
import 'package:test_internship_enlab/modules/home/models/HistorySave.dart';
import 'package:test_internship_enlab/modules/quizz/models/YourAnswer.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';
import 'package:test_internship_enlab/themes/styles_text.dart';

class QuizzDetailPage extends StatelessWidget {
  const QuizzDetailPage({Key? key, required this.data}) : super(key: key);
  final HistorySave data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
            "Detail ${data.time}",
            style: StylesText.body1.copyWith(color: AppColors.white),
          ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "${data.resultYourQuizz.countCorrect}/${data.resultYourQuizz.listYourQuizz.length}",
                  style: StylesText.body2.copyWith(
                    color: data.resultYourQuizz.countCorrect >= 5 ? AppColors.accent1 : AppColors.red,
                  ),
                ),
                Text(
                  " (${data.resultYourQuizz.seconds}s)",
                  style: StylesText.body4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppColors.primary1,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              _widgetListQuestion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetListQuestion() {
    var listYourQuizz = data.resultYourQuizz.listYourQuizz;
    return Column(
      children: [
        for(var i = 0; i < listYourQuizz.length;i++ ) _widgetQuestion(index: i, value: listYourQuizz[i])
      ],
    );
  }

  Widget _widgetQuestion({required YourAnswer value, required int index}) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.r),
      margin: EdgeInsets.only(bottom: 10.r),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 2.r),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.7.sw,
                child: Text(
                  "${index + 1}. ${value.question}",
                  style: StylesText.header2.copyWith(
                    color: value.isCorrect ? AppColors.accent1 : AppColors.red,
                  ),
                ),
              ),
              Text(
                "${value.isCorrect}",
                style: StylesText.header2.copyWith(
                  color: value.isCorrect ? AppColors.accent1 : AppColors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.r,),
          for(var i = 0; i< value.allAnswer.length; i++) SecondButton(
              onPressed: () {},
              answer: value.allAnswer[i],
              correctAnswer: value.correctAnswer,
              isChecked: value.yourChoose == value.allAnswer[i],
              isSubmited: true,
          ),
        ],
      ),
    );
  }

  void onPressedNavigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
