part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcretNumber extends NumberTriviaEvent {
  final String? numberString;
  GetTriviaForConcretNumber(this.numberString);
}

class GetTriviaFromRandomNumber extends NumberTriviaEvent{
  
}
