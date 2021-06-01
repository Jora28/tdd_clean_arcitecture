import 'package:tdd_pattern/core/usecases/usecase.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_random_number_trivia.dart';

class MocknumberTriviaRepository extends Mock
    implements NumberTriviaRepesotory {}

void main() {
  GetRandomNumberTrivia? usecase;
  MocknumberTriviaRepository? mocknumberTriviaRepository;
  setUp(() {
    mocknumberTriviaRepository = MocknumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mocknumberTriviaRepository!);
  });
  //final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: "text");
  test('should get trivia  from the repository', () async {
    when(mocknumberTriviaRepository?.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));
    final result = await usecase!(NoParams());
    expect(result, Right(tNumberTrivia));
    verify(mocknumberTriviaRepository?.getRandomNumberTrivia());
    verifyNoMoreInteractions(mocknumberTriviaRepository);
  });
}
