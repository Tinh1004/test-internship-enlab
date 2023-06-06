import 'package:flutter/material.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';

class SecondButton extends StatelessWidget {
  const SecondButton({
    Key? key,
    required this.onPressed,
    required this.answer,
    this.isChecked = false,
    this.isSubmited = false,
    this.correctAnswer,
  }) : super(key: key);
  final Function onPressed;
  final String answer;
  final bool? isChecked;
  final bool? isSubmited;
  final String? correctAnswer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // bloc.onPessedCheckedAnswer(answer);
        onPressed();
      },
      child: Container(
        width: 1.sw,
        height: 60.h,
        margin: EdgeInsets.only(bottom: 12.h),
        padding:
            EdgeInsets.only(top: 8.r, bottom: 8.r, left: 16.r, right: 16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(
                color: isSubmited == true
                    ? isChecked == true
                        ? answer == correctAnswer
                            ? Colors.green
                            : Colors.red
                        : answer == correctAnswer ? Colors.green : Colors.white
                    : isChecked == true
                        ? Colors.red
                        : Colors.white,
                width: 2.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 0.6.sw,
              child: Text(
                answer,
                style: TextStyle(
                  color: isSubmited == true
                      ? isChecked == true
                      ? answer == correctAnswer
                      ? Colors.green
                      : Colors.red
                      : answer == correctAnswer ? Colors.green : Colors.white
                      : isChecked == true
                      ? Colors.red
                      : Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              isSubmited == true
                  ? isChecked == true
                      ? answer == correctAnswer
                          ? Icons.check_circle_outline
                          : Icons.close_sharp
                      : answer == correctAnswer ?Icons.check_circle_outline : Icons.circle_outlined
                  : isChecked == true
                      ? Icons.check_circle_outline
                      : Icons.circle_outlined,
              size: 20.r,
              color: isSubmited == true
                  ? isChecked == true
                      ? answer == correctAnswer
                          ? Colors.green
                          : Colors.red
                      : answer == correctAnswer ? Colors.green : Colors.white
                  : isChecked == true
                      ? Colors.red
                      : Colors.white,
            ),
            // Icon(Icons.check_circle_outline, color: AppColors.white)
          ],
        ),
      ),
    );
  }
}
