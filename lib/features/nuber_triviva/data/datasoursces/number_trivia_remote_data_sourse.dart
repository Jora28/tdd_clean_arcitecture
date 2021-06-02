import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSourse {
  Future<NumberTriviaModel?>? getConcretNuberTivia(int? number);
  Future<NumberTriviaModel?>? getRandomNumberTrivia();
}
