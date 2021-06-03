import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tdd_pattern/core/util/input_converter.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia? getConcreteNumberTrivia;
  final GetRandomNumberTrivia? getRandomNumberTrivia;
  final InputConverter? inputConverter;
  NumberTriviaBloc(
      {this.getConcreteNumberTrivia,
      this.getRandomNumberTrivia,
      this.inputConverter})
      : super(Empty());

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcretNumber) {
      inputConverter?.stringToUnsignedInteger(event.numberString);
    }
  }
}
