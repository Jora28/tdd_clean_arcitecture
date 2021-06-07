import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_pattern/core/util/input_converter.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreateNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreateNumberTrivia mockGetConcreateNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreateNumberTrivia = MockGetConcreateNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(mockGetConcreateNumberTrivia,
        mockGetRandomNumberTrivia, mockInputConverter);
  });

  test("inital should be Empty", () {
    expect(bloc.initialState, Empty());
  });
  group("GetTriviaForConcretenumber", () {
    final tNumberString = "1";
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'text trivia');
    test(
        "should call the InputConverter to validate and conver the string to an unsigned integer",
        () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(Right(tNumberParsed));
      bloc.add(GetTriviaForConcretNumber(tNumberString));
      await untilCalled(
          () => mockInputConverter.stringToUnsignedInteger(any()));
      verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
    });
    test('should emit[Error] when input is infalid', () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(Left(InvalidInputFailure()));
      final expacted = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.state, emitsInOrder(expacted));
      bloc.add(GetTriviaForConcretNumber(tNumberString));
    });

    test('should get data from the concrete use case ', () async {
      when(() => mockInputConverter.stringToUnsignedInteger(any()))
          .thenReturn(Right(tNumberParsed));
      when(() => mockGetConcreateNumberTrivia(any()))
          .thenAnswer((_) async => Right(tNumberTrivia));
     //bloc.add(GetTriviaForConcretNumber(any()));
      await untilCalled(() => mockGetConcreateNumberTrivia(any()));
     verify(() => mockGetConcreateNumberTrivia(Params(number: tNumberParsed,)));
    },timeout: Timeout(Duration(seconds: 1)));
  });
}
