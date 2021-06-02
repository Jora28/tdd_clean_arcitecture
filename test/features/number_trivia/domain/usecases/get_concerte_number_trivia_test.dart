import 'package:mocktail/mocktail.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
// import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/repositories/number_trivia_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_concrete_number_trivia.dart';

class MocknumberTriviaRepository extends Mock
    implements NumberTriviaRepesotory {}

void main() {
  GetConcreteNumberTrivia? usecase;
  MocknumberTriviaRepository? mocknumberTriviaRepository;
  setUp(() {
    mocknumberTriviaRepository = MocknumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mocknumberTriviaRepository!);
  });
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: "text");
  test('should get trivia for the number from the repository', () async {
    when(()=>mocknumberTriviaRepository?.getConcretNuberTivia(any()))
        .thenAnswer((_) async => Right(tNumberTrivia));
    final result = await usecase!(Params(number: tNumber));
    expect(result, Right(tNumberTrivia));
    verify(()=>mocknumberTriviaRepository?.getConcretNuberTivia(tNumber));
    verifyNoMoreInteractions(mocknumberTriviaRepository);
  });
}
