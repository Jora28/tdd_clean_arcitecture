import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/core/error/failure.dart';
import 'package:tdd_pattern/core/network/noetwork_info.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/repositories/numer_trivia_repository_impl.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';

class MockRemoteDataSourse extends Mock
    implements NumberTriviaRemoteDataSourse {}

class MockLocalDataSourse extends Mock implements NumberTriviaLocalDataSourse {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  NumberTriviaRepositoryImpl? repositoryImpl;
  MockLocalDataSourse? mockLocalDataSourse;
  MockRemoteDataSourse? mockRemoteDataSourse;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSourse = MockRemoteDataSourse();
    mockLocalDataSourse = MockLocalDataSourse();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSourse: mockRemoteDataSourse,
      localDataSourse: mockLocalDataSourse,
      networkInfo: mockNetworkInfo,
    );
  });
  void runTestsOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }


  final tNumberTriviaModel =
      NumberTriviaModel(text: "test trivia", number: 123);
  final NumberTrivia? tnumberTrivia = tNumberTriviaModel;
  group("getRandomNumberTrivia", () {
    test("should check if the divice is online", () async {
      when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockNetworkInfo.isConnected);
    });
  });

  runTestsOnline(() {
    test("should remote data when the call to rempte data source is succes",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      expect(result, Right(tnumberTrivia));
    });
    test(
        "should cache the data locally when the call to rempte data source is succes",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      //expect(result, Right(tnumberTrivia));
      verify(()=>mockLocalDataSourse?.cachenumbertrivia(tNumberTriviaModel));
    });
    test(
        "should return serfer failure  when the call to rempte data source is unsucces",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenThrow(ServerException());
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      verifyZeroInteractions(mockLocalDataSourse);
      expect(result, Left(ServerFailure()));
    });
  });

  runTestsOffline(() {
    test(
        "should return last loccaly cached data when the cached data is present",
        () async {
      when(()=>mockLocalDataSourse?.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verifyZeroInteractions(mockRemoteDataSourse);
      verify(()=>mockLocalDataSourse?.getLastNumberTrivia());
      expect(result, Right(tnumberTrivia));
    });
    test("should return CachedFailure  when there is no cached data   present",
        () async {
      when(()=>mockLocalDataSourse?.getLastNumberTrivia())
          .thenThrow(CacheExceptions());
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verifyZeroInteractions(mockRemoteDataSourse);
      verify(()=>mockLocalDataSourse?.getLastNumberTrivia());
      expect(result, Left(CacheFailure()));
    });
  });

  group("getConcretenumberTrivia", () {
    test("should check if the divice is online", () async {
      when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockNetworkInfo.isConnected);
    });
  });

  runTestsOnline(() {
    test("should remote data when the call to rempte data source is succes",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      expect(result, Right(tnumberTrivia));
    });
    test(
        "should cache the data locally when the call to rempte data source is succes",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      //expect(result, Right(tnumberTrivia));
      verify(()=>mockLocalDataSourse?.cachenumbertrivia(tNumberTriviaModel));
    });
    test(
        "should return serfer failure  when the call to rempte data source is unsucces",
        () async {
      when(()=>mockRemoteDataSourse?.getRandomNumberTrivia())
          .thenThrow(ServerException());
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verify(()=>mockRemoteDataSourse?.getRandomNumberTrivia());
      verifyZeroInteractions(mockLocalDataSourse);
      expect(result, Left(ServerFailure()));
    });
  });

  runTestsOffline(() {
    test(
        "should return last loccaly cached data when the cached data is present",
        () async {
      when(()=>mockLocalDataSourse?.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verifyZeroInteractions(mockRemoteDataSourse);
      verify(()=>mockLocalDataSourse?.getLastNumberTrivia());
      expect(result, Right(tnumberTrivia));
    });
    test("should return CachedFailure  when there is no cached data   present",
        () async {
      when(()=>mockLocalDataSourse?.getLastNumberTrivia())
          .thenThrow(CacheExceptions());
      final result = await repositoryImpl?.getRandomNumberTrivia();
      verifyZeroInteractions(mockRemoteDataSourse);
      verify(()=>mockLocalDataSourse?.getLastNumberTrivia());
      expect(result, Left(CacheFailure()));
    });
  });
}
