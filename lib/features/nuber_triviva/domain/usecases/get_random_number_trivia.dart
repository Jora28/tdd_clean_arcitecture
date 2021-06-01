import 'package:equatable/equatable.dart';
import 'package:tdd_pattern/core/error/faailures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/core/usecases/usecase.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  NumberTriviaRepesotory? repesotory;
  GetRandomNumberTrivia(this.repesotory);
  @override
  Future<Either<Failure?, NumberTrivia?>?>? call(params) async {
    return await repesotory?.getRandomNumberTrivia();
  }
}
