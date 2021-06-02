import 'package:flutter/material.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/core/network/noetwork_info.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia__remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepesotory {
  final NumberTriviaRemoteDataSourse? remoteDataSourse;
  final NumberTriviaLocalDataSourse? localDataSourse;
  final NetWorkInfo? networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.localDataSourse,
      @required this.networkInfo,
      @required this.remoteDataSourse});
  @override
  Future<Either<Failure?, NumberTrivia?>?>? getConcretNuberTivia(
      int? number) async {
    return await _getTrivia(() {
      return remoteDataSourse?.getConcretNuberTivia(number);
    });
  }

  @override
  Future<Either<Failure?, NumberTrivia?>?>? getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSourse?.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure?, NumberTrivia?>?>? _getTrivia(
      Future<NumberTriviaModel?>? Function() getConcretOrRandom) async {
    var network = await networkInfo?.isConnected;
    if (network!) {
      try {
        final remoteTrivia = await getConcretOrRandom();
        localDataSourse?.cachenumbertrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSourse?.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheExceptions {
        return Left(CacheFailure());
      }
    }
  }
}
