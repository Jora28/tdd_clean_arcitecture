import 'dart:convert';

import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSourse {
  Future<NumberTriviaModel?>? getConcretNuberTivia(int? number);
  Future<NumberTriviaModel?>? getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourseImpl implements NumberTriviaRemoteDataSourse {
  final http.Client client;
  NumberTriviaRemoteDataSourseImpl({required this.client});
  @override
  Future<NumberTriviaModel?>? getConcretNuberTivia(int? number) async {
    final response = await client.get(
        Uri.parse('http://numbersapi.com/$number'),
        headers: {'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel?>? getRandomNumberTrivia() {
    return null;
  }
}
