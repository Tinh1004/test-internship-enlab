import 'package:flutter/material.dart';
import 'package:test_internship_enlab/common/widgets/button/main_button.dart';
import 'package:test_internship_enlab/modules/questions/QuizzPage.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/app_dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
          Container(
            height: 100.r,
            width: 100.r,
            decoration: const BoxDecoration(color: Colors.orange),
          ),
          SizedBox(
            height: 10.h,
          ),
          MainButton(
            onPressed: onPresedNavigate,
            title: "Start Quiz!",
            minWidth: 0.3.sw,
            backgroundColor: AppColors.accent1,
            radius: 55.r,
          ),
          SizedBox(
            height: 10.h,
          ),
          MainButton(
            onPressed: (){},
            title: "History",
            minWidth: 0.3.sw,
            backgroundColor: AppColors.accent1,
            radius: 55.r,
          ),
        ],
      ),
    );
  }

  void onPresedNavigate(){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>QuizzPage()));
  }
}
