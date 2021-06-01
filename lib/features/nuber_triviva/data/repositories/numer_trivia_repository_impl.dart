import 'package:flutter/material.dart';
import 'package:tdd_pattern/core/platform/noetwork_info.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia__remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/core/error/faailures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepesotory {
  final NumberTriviaRemoteDataSourse? remoteDataSourse;
  final NumberTriviaLocalDataSourse? localDataSourse;
  final NetworkInfo? networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.localDataSourse,
      @required this.networkInfo,
      @required this.remoteDataSourse});
  @override
  Future<Either<Failure?, NumberTrivia?>?>? getConcretNuberTivia(
      int? number) async {
    networkInfo?.isConnected;
    Right<Failure?, NumberTrivia?>? asd = Right(await remoteDataSourse?.getConcretNuberTivia(number));
    return asd;
  }

  @override
  Future<Either<Failure?, NumberTrivia?>?>? getRandomNumberTrivia() {
    return null;
  }
}
