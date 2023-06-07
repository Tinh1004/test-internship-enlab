part of 'quizz_cubit.dart';

@immutable
abstract class QuizzState {}

class QuizzInitial extends QuizzState {}

class QuizzLoading extends QuizzState {}

class QuizzGetDataSuccess extends QuizzState {
  final List<Quizz> listData;
  QuizzGetDataSuccess(this.listData);
}

class QuizzGetDataFailed extends QuizzState {
  final String errorMessage;

  QuizzGetDataFailed(this.errorMessage);
}

class QuizzSubmitSuccess extends QuizzState {
  final String message;
  QuizzSubmitSuccess(this.message);
}