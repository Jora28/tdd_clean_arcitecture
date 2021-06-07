import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tdd_pattern/core/error/failure.dart';
import 'package:tdd_pattern/core/util/input_converter.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';

const String CACHE_FAILURE_MESSAGE = 'Cache failure';

const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input the number must be a zero or negativer';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  late GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia? getRandomNumberTrivia;
  final InputConverter? inputConverter;

  NumberTriviaBloc(
      this.getConcreteNumberTrivia,
      this.getRandomNumberTrivia,
      this.inputConverter)
      : super(Empty());

  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcretNumber) {
      Either<Failure, int>? inputEither =
          inputConverter?.stringToUnsignedInteger(event.numberString);

      inputEither?.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield getConcreteNumberTrivia(Params(number: integer));
      });
      yield Error(message: "invalid Input");
    }
  }
}
