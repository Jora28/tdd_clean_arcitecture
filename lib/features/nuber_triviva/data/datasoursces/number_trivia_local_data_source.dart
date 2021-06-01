import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSourse {
  Future<NumberTriviaModel?>? getLastNumberTrivia();
  Future<void>? cachenumbertrivia(NumberTriviaModel? numberTriviaModel);
}
