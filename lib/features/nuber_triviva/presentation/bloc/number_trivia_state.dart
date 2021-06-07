part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  //NumberTriviaState([List props = const<dynamic>[]]);

  // @override
  // List<Object?> get props => [];
}

class Empty extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loaded extends NumberTriviaState {
  final NumberTrivia? trivia;
  Loaded({@required this.trivia});


  @override
  List<Object?> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String? message;
  Error({@required this.message});
   @override
  List<Object?> get props => [message];
}
