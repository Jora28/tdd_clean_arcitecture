import 'package:dartz/dartz.dart';

import 'package:tdd_pattern/core/error/faailures.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepesotory {
  Future<Either<Failure?, NumberTrivia?>?>? getConcretNuberTivia(int? number);
  Future<Either<Failure?, NumberTrivia?>?>? getRandomNumberTrivia();
}
