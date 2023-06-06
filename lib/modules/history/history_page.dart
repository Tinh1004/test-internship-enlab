import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_internship_enlab/common/widgets/button/main_button.dart';
import 'package:test_internship_enlab/modules/history/quizz_detail_page.dart';
import 'package:test_internship_enlab/modules/home/bloc/home_cubit.dart';
import 'package:test_internship_enlab/modules/home/models/HistorySave.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';
import 'package:test_internship_enlab/themes/styles_text.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.homeBloc}) : super(key: key);
  final HomeCubit homeBloc;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: widget.homeBloc,
        builder: (context, state) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(color: AppColors.primary1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "History Page",
                        style: StylesText.header1.copyWith(color: AppColors.accent1),
                      ),
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
                    height: 40.h,
                  ),
                  Text(
                    "List Your Quizz submited!",
                    style: StylesText.header2.copyWith(color: AppColors.white),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  state is HomeInitial || state is HomeLoading
                      ? Text(
                    "List Empty...",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  )
                      : SizedBox.shrink(),
                  state is HomeSaveSuccess ? _widgetListYourQuizz(state.listData) : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetListYourQuizz(List<HistorySave> listData){
    return Column(
      children: [
        for(var i = 0; i < listData.length ; i++) _widgetYourQuizz(data: listData[i])
      ],
    );
  }

  Widget _widgetYourQuizz({required HistorySave data}){
    return Container(
      width: 1.sw,
      height: 65.h,
      margin: EdgeInsets.only(bottom: 20.r),
      padding: EdgeInsets.only(left: 15.r, right: 15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65.r),
        border: Border.all(
          color: AppColors.grey, width: 2.r,),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         SizedBox(
           width: 0.5.sw,
           child:  Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(
                 "Correct: ",
                 style: StylesText.body2.copyWith(
                   color: AppColors.white,
                 ),
               ),
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
         ),
          MainButton(
            onPressed: () {
              onPressedNavigateDetail(data);
            },
            title: "Detail",
            minWidth: 0.2.sw,
            height: 40.r,
            radius: 40.r,
              backgroundColor: AppColors.accent1,
          )
        ],
      ),
    );
  }

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }
  void onPressedNavigateDetail(HistorySave data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzDetailPage(data: data),));
  }
}
