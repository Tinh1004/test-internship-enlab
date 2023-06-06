import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:test_internship_enlab/data/repository.dart';
import 'package:test_internship_enlab/models/Quizz.dart';
import 'package:test_internship_enlab/modules/home/models/HistorySave.dart';
import 'package:test_internship_enlab/modules/quizz/models/SaveQizz.dart';
import 'package:test_internship_enlab/modules/quizz/models/YourAnswer.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<HistorySave> listData =[];

  void initData(){
    emit(HomeLoading());
    emit(HomeSaveSuccess(listData));
  }

  void addData(SaveQizz value){
    var newList = [...listData];
    emit(HomeLoading());
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(now);
    var newData = HistorySave(
        resultYourQuizz: value,
        time: "${formattedDate}"
    );
    newList.insert(0, newData);
    listData = newList;
    emit(HomeSaveSuccess(listData));
  }
}
