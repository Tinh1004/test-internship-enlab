part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSaveSuccess extends HomeState {
  final List<HistorySave> listData;
  HomeSaveSuccess(this.listData);
}

class HomeSaveFailed extends HomeState {
  final String errorMessage;
  HomeSaveFailed(this.errorMessage);
}
