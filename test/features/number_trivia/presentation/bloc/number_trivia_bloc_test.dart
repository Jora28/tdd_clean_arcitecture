import 'dart:convert';
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
  NumberTriviaBloc? bloc;
  MockGetConcreateNumberTrivia? mockGetConcreateNumberTrivia;
  MockGetRandomNumberTrivia? mockGetRandomNumberTrivia;
  MockInputConverter? mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreateNumberTrivia = MockGetConcreateNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreateNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test("inital should be Empty", () {
    expect(bloc?.initialState, Empty());
  });
  group("GetTriviaForConcretenumber", () {
    final tNumberString = "1";
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'text trivia');
    test(
        "should call the InputConverter to validate and conver the string to an unsigned integer",
        () async {
      when(() => mockInputConverter?.stringToUnsignedInteger(any()))
          .thenReturn(Right(tNumberParsed));
      bloc?.mapEventToState(GetTriviaForConcretNumber(tNumberString));
      verifyNever(
          () => mockInputConverter?.stringToUnsignedInteger(tNumberString));
    });
  });
}
