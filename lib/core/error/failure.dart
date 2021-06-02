import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List propertties = const []]);
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
