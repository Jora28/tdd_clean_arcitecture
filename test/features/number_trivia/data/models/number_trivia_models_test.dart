import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';
import 'package:tdd_pattern/features/nuber_triviva/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test text");

  test("should be subclass of NumberTrivia entity", () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('fromJson', () {
    test("return a valid model when the JSON number is an intejer", () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, equals(tNumberTriviaModel));
    });
    test("return a valid model when the JSON number is an double", () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, equals(tNumberTriviaModel));
    });
  });

  group("ToJson", () {
    test("should return a JSON map containing the proper data ", () async {
      final result = tNumberTriviaModel.toJson();
      final expactedMap = {
        "text": "Test text",
        "number": 1,
      };
      expect(result, expactedMap);
    });
  });
}
