import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class NumberTriviaRemoteDataSourse {
  Future<NumberTriviaModel?>? getConcretNuberTivia(int? number);
  Future<NumberTriviaModel?>? getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourseImpl implements NumberTriviaRemoteDataSourse {
  final http.Client? client;
  NumberTriviaRemoteDataSourseImpl({@required this.client});
  @override
  Future<NumberTriviaModel?>? getConcretNuberTivia(int? number) {
    Uri url = Uri.parse('http://numbersapi.com/$number');
    //client?.get(url, headers: {'Content-Type': 'application/json'});
  }

  @override
  Future<NumberTriviaModel?>? getRandomNumberTrivia() {
    return null;
  }
}
