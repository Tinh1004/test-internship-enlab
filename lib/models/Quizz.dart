import 'dart:math';

class Opentdb {
  int? response_code;
  List<Quizz>? results;
  Opentdb({
    this.response_code,
    this.results,
  });

  factory Opentdb.fromMap(map) {
    var data = <Quizz>[];
    if (map['results'] != null) {
      map['results'].forEach((v) {
        data!.add(new Quizz.fromMap(v));
      });
    }
    return Opentdb(
      response_code: map['response_code'],
      results: data
    );
  }
}

class Quizz {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;
  List<String>? allAnswer;

  Quizz({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
    this.allAnswer,
  });

  factory Quizz.fromMap(map) {
    List<String> listAnswer = [];
    if (map['incorrect_answers'] != null) {
      map['incorrect_answers'].forEach((v) {
        listAnswer!.add(v as String);
      });
    }
    String correctAnswer = map['correct_answer'] ?? '';
    int index = randomIndex(listAnswer.length);
    var allAnswer = [...listAnswer];
    allAnswer.insert(index, correctAnswer);
    return Quizz(
        category: map['category'] ?? '',
        type: map['type'] ?? '',
        difficulty: map['difficulty'] ?? '',
        correctAnswer: correctAnswer,
        incorrectAnswers: listAnswer,
        question: map['question'],
        allAnswer: allAnswer,
    );
  }
}

int randomIndex(int length){
  Random random = Random();
  int randomIndex = random.nextInt(length);
  return randomIndex;
}
