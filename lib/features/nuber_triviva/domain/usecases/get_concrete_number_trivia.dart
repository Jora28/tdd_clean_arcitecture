import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tdd_pattern/core/error/failure.dart';
import 'package:tdd_pattern/core/usecases/usecase.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepesotory? repesotory;
  GetConcreteNumberTrivia(this.repesotory);
  Future<Either<Failure?, NumberTrivia?>?> execute(
      {@required int? number}) async {
    return await repesotory?.getConcretNuberTivia(number);
  }

  @override
  Future<Either<Failure?, NumberTrivia?>?>? call(Params? params) async {
    return await repesotory?.getConcretNuberTivia(params?.number);
  }
}

class Params extends Equatable {
  final int? number;
  Params({@required this.number});

  @override
  List<Object?> get props => [number];
}
