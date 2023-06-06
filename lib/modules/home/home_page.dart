import 'package:flutter/material.dart';
import 'package:test_internship_enlab/common/widgets/button/main_button.dart';
import 'package:test_internship_enlab/modules/history/history_page.dart';
import 'package:test_internship_enlab/modules/home/bloc/home_cubit.dart';
import 'package:test_internship_enlab/modules/quizz/quizz_page.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';
import 'package:test_internship_enlab/utils/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(color: AppColors.primary1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200.r,
            height: 200.r,
            child: Image(
              image: AssetImage(AssetPNG.block),
              width: 200.r,
              height: 200.r,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          MainButton(
            onPressed: (){onPresedNavigate(QuizzPage(homeBloc: bloc,));},
            title: "Start Quiz!",
            minWidth: 0.3.sw,
            backgroundColor: AppColors.accent1,
            radius: 55.r,
          ),
          SizedBox(
            height: 15.h,
          ),
          MainButton(
            onPressed: (){onPresedNavigate(HistoryPage(homeBloc: bloc,));},
            title: "History",
            minWidth: 0.3.sw,
            backgroundColor: AppColors.primary2,
            radius: 55.r,
          ),
        ],
      ),
    );
  }

  void onPresedNavigate(Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
  }

}
