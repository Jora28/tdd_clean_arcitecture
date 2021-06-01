import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_pattern/core/platform/noetwork_info.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia__remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/repositories/numer_trivia_repository_impl.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';

class MockRemoteDataSourse extends Mock
    implements NumberTriviaRemoteDataSourse {}

class MockLocalDataSourse extends Mock implements NumberTriviaLocalDataSourse {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl? repositoryImpl;
  MockLocalDataSourse? mockLocalDataSourse;
  MockRemoteDataSourse? mockRemoteDataSourse;
  MockNetworkInfo? mockNetworkInfo;

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
  final int? tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel(text: "test trivia", number: tNumber);
  final NumberTrivia? tnumberTrivia = tNumberTriviaModel;
  group("getConcretenumberTrivia", () {
    test("should check if the divice is online", () async {
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      repositoryImpl?.getConcretNuberTivia(tNumber);
      verify(mockNetworkInfo?.isConnected);
    });
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
    });
    test("should remote data when the call to rempte data source is succes",
        () async {
      when(mockRemoteDataSourse?.getConcretNuberTivia(any))
          .thenAnswer((realInvocation) async => tNumberTriviaModel);
      final result = await repositoryImpl?.getConcretNuberTivia(tNumber);
      verify(mockRemoteDataSourse?.getConcretNuberTivia(tNumber));

      expect(result, equals(Right(tnumberTrivia)));
    });
  });

  group("device is offnline", () {
    setUp(() {
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => false);
    });
  });
}
