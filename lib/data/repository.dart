import 'package:dio/dio.dart';
import 'package:test_internship_enlab/models/Quizz.dart';

class Repository {
  final dio = Dio();

  Future<List<Quizz>> getData() async {
    try {
      var url = 'https://opentdb.com/api.php?amount=10';
      var res = await dio.get(url);
      print("res ${res}");
      var data = res.data;
      var result = Opentdb.fromMap(data);
      return result.results ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
